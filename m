Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Sep 2010 14:05:52 +0200 (CEST)
Received: from 6-61.252-81.static-ip.oleane.fr ([81.252.61.6]:59332 "EHLO
        zebulon.innova-card.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1490978Ab0IGMFs convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Sep 2010 14:05:48 +0200
Received: from [88.173.184.45] ([88.173.184.45])
        by zebulon.innova-card.com;
        Tue, 7 Sep 2010 14:04:37 +0200
To:     naren.mehra@gmail.com
Cc:     msundius@cisco.com, dvomlehn@cisco.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org, sshtylyov@mvista.com
From:   "Brian FOSTER" <brian.foster@innova-card.com>
Subject: Re: Memory regression test tool on MIPS needed
In-Reply-To: AANLkTikya-sDVRLpPisSWs15EU_zphm==z0hEB45tLH5@mail.gmail.com
Message-ID: <20100907120437.a3d0bb0d@zebulon.innova-card.com>
Date:   Tue, 07 Sep 2010 14:04:37 +0200
X-User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8) Gecko/20100723
        Ubuntu/9.10 (karmic) Firefox/3.6.8
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-archive-position: 27726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian.foster@innova-card.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 5184

> Sent: Tue, 07 Sep 2010 13:34:15 +0200
> Subject: Memory regression test tool on MIPS needed
> From: naren.mehra@gmail.com
> To: msundius@cisco.com, dvomlehn@cisco.com, ralf@linux-mips.org,
>     linux-mips@linux-mips.org, sshtylyov@mvista.com
> 
> Hi,
> 
> I have recently applied the sparsemem patch on my mips board.
> Now I intend to write a detail analysis with its performance before
> and after the patch and whether it has broken anything in the memory
> management system.
> For that I need a memory regression tool that works on mips board.
> Can anybody help me with that ?

Naren,

 It may or may not be helpful, but take a look at ‘memtester’,

    http://pyropus.ca/software/memtester/

 (It is also in BuildRoot.)  We've successfully used v4.12 as
 part the validation of a H/W memory controller on a new SoC.

cheers!
	-blf-
