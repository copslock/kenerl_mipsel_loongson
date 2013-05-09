Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 May 2013 16:44:52 +0200 (CEST)
Received: from mail-pd0-f176.google.com ([209.85.192.176]:44686 "EHLO
        mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823763Ab3EIOooh3IL5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 May 2013 16:44:44 +0200
Received: by mail-pd0-f176.google.com with SMTP id x10so2050926pdj.21
        for <multiple recipients>; Thu, 09 May 2013 07:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=CE5oU9GM7Dm8dD3117JUKQdSmYnbkg2ztSlu930IHRM=;
        b=VX55/170EVXL4lOIcjRJ8F/5YoYVG7iHnKXmwzU6MG5YcccwFU81521m+wi+t6Kulx
         WLJgBwK2CvKE8vEYAg2WNed1Hb8cOHLjdEWSIzodkldEMrIFfdpQ+iDeC+UptnRtR+S6
         r19lUrp5EPrVgaxTwpsXXXOfr8nGMR0cUUeUTCUjNDY0ZRrMFyNDrM+GUKo+po4uLCob
         vqz0vGR1TOMNCdZfVqhiTofNqzjDMCQc12jNutkv5q5N4OfbZljocGp6HNGZhO6Lj+Ee
         X1vqlfmERYmLtD6qXWX0DFUkQSFxXSfxUBP1VSOFAqueIwYmQPlLdLG2+NKs0Jbj/wWu
         kR2A==
X-Received: by 10.68.196.1 with SMTP id ii1mr12970747pbc.200.1368110677339;
        Thu, 09 May 2013 07:44:37 -0700 (PDT)
Received: from hades (114-25-190-57.dynamic.hinet.net. [114.25.190.57])
        by mx.google.com with ESMTPSA id al2sm3323424pbc.25.2013.05.09.07.44.22
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 09 May 2013 07:44:36 -0700 (PDT)
Date:   Thu, 9 May 2013 22:44:06 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 0/2] MIPS: fix get_frame_info and frame_info_init
Message-ID: <20130509144406.GB3562@hades>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi,

There are a couple of issues with the current frame_info_init and
get_frame_info implementation. get_frame_info cannot detect sibling
call and the result stored in schedule_mfi is wrong.

1. get_frame_info and sibling call

The first issue is that get_frame_info() did not consider sibling call
case. When a sibling call function is given, it may come across 
function boundary and return wrong frame info instead.

For example, in frame_info_init(), schedule is passed to
get_frame_info() and io_schedule's info is returned instead of
schedule's.

801de7b4 <schedule>:
801de7b4:       8f820000        lw      v0,0(gp)
801de7b8:       8c420000        lw      v0,0(v0)
801de7bc:       080778ab        j       801de2ac <__schedule>
801de7c0:       00000000        nop

801de7c4 <io_schedule>:
801de7c4:       27bdffe8        addiu   sp,sp,-24
801de7c8:       afbf0014        sw      ra,20(sp)
801de7cc:       3c028021        lui     v0,0x8021
801de7d0:       24425a60        addiu   v0,v0,23136
801de7d4:       c04303f8        lwc0    $3,1016(v0)
801de7d8:       24630001        addiu   v1,v1,1
801de7dc:       e04303f8        swc0    $3,1016(v0)
801de7e0:       1060fffc        beqz    v1,801de7d4 <io_schedule+0x10>
801de7e4:       00000000        nop
          ......

2. schedule_mfi

After compiler compilation, schedule() is reduced to a sibling call
stub to __schedule(), and due to issue 1, frame_info_init()
is actually extracting wrong info from the function that follows
schedule(), i.e. schedule_io().

Current optimization
801de7b4 <schedule>:
801de7b4:       8f820000        lw      v0,0(gp)
801de7b8:       8c420000        lw      v0,0(v0)
801de7bc:       080778ab        j       801de2ac <__schedule>
801de7c0:       00000000        nop

One solution is to compile schedule() in kernel/sched/core.c using
-fno-omit-frame-pointer and -fno-optimize-sibling-calls, but this
will incur performance degradation.

With -fno-omit-frame-pointer -fno-optimize-sibling-calls
801dee64 <schedule>:
801dee64:       27bdfff8        addiu   sp,sp,-8
801dee68:       afbe0004        sw      s8,4(sp)
801dee6c:       03a0f021        move    s8,sp
801dee70:       8f820000        lw      v0,0(gp)
801dee74:       03c0e821        move    sp,s8
801dee78:       8fbe0004        lw      s8,4(sp)
801dee7c:       8c420000        lw      v0,0(v0)
801dee80:       08077a4f        j       801de93c <__schedule>
801dee84:       27bd0008        addiu   sp,sp,8

Another solution is to extract schedule_mfi from the real scheduler
__schedule.

I am sending two patches, one to fix get_frame_info sibling call
issue, the other to extract schedule_mfi from __schedule. Please
help review their validity.

Tony Wu (2):
  MIPS: detect sibling call in get_frame_info
  MIPS: get schedule_mfi info from __schedule

 arch/mips/kernel/process.c |   28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)
