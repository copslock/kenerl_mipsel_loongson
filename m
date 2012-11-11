Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2012 19:19:34 +0100 (CET)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:43569 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826641Ab2KKSTSgojBb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Nov 2012 19:19:18 +0100
Received: by mail-ee0-f49.google.com with SMTP id c1so3016351eek.36
        for <multiple recipients>; Sun, 11 Nov 2012 10:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=g5sqh49tccngtbqGwp6/8VJri83bis6tqBH4GGSo4mY=;
        b=VRO3ebb31r9c3ddlkBPq44MV3w1+ua6OZD5UxLK3boENi/9KsZOQkvWzCn8ej+hQjy
         qxmmu/15y8XUHk1kh5AmrsRzsk7++nmiCCtwugP0y+R76XTYsBnQ8h4FCLTSVOBl46hF
         9rjgBIxcebs/BYvbrDMhuo/Rm+IyHaIhfbRzMV1Sux9/GDkGOK3MSrsyNHK6psGtjAsO
         KNMLlf5b4ToJZOP/kvpVuuaOzgtLLqA0wX87QZA/KHh4YWIZW9MxtQ9bZQMt1A5PBy8j
         02kQ6H9j0HB1DSIrgyJh2vhdrivFnMNQchHgGZst0BAXkvdpdbHCpzaR1uYUxInHVS1G
         oWmg==
MIME-Version: 1.0
Received: by 10.14.182.5 with SMTP id n5mr55596355eem.5.1352657953224; Sun, 11
 Nov 2012 10:19:13 -0800 (PST)
Received: by 10.14.216.193 with HTTP; Sun, 11 Nov 2012 10:19:13 -0800 (PST)
In-Reply-To: <1352657010-9632-1-git-send-email-blogic@openwrt.org>
References: <1352657010-9632-1-git-send-email-blogic@openwrt.org>
Date:   Sun, 11 Nov 2012 10:19:13 -0800
Message-ID: <CAJiQ=7DKn9hUr_Y2xn6r7ZRNQ3FTOXe+rMq=ZigxMMZdL-d0TA@mail.gmail.com>
Subject: Re: [MIPS] Pull request for 3.8
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sun, Nov 11, 2012 at 10:03 AM, John Crispin <blogic@openwrt.org> wrote:
> Hi Ralf,
>
> here is my queue of patches i consider ready for 3.8.
[snip]
> Kevin Cernekee (1):
>       MIPS: tlbex: Fix section mismatches

The section mismatch in question first showed up in 3.7-rc2 with
commit 02a5417751, so it's a recent regression with an easy fix.

What do you think about rolling the fix into 3.7 instead of 3.8?
