Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2006 03:24:16 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.179]:14059 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20038958AbWIZCYO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Sep 2006 03:24:14 +0100
Received: by py-out-1112.google.com with SMTP id i49so2323439pyi
        for <linux-mips@linux-mips.org>; Mon, 25 Sep 2006 19:24:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding;
        b=XGhN7TE/q74xrqdO/Y+e3Fzqr597p5LugBH6zSdAeHO2Rc/UfLiPjT0mlFxhxHYMO9hB29BRdwMWuVXrcRQHuiDHTgry4+sJkOLdwsTEYx1cHtak0bof7ehJIDYup2D1v8qoREf4TJGJy9iQ6N/eWuTubHI/Q7ycoPMKigoYDuo=
Received: by 10.35.91.1 with SMTP id t1mr419389pyl;
        Mon, 25 Sep 2006 19:24:13 -0700 (PDT)
Received: from ?192.168.1.3? ( [61.125.212.22])
        by mx.gmail.com with ESMTP id v50sm3558723pyv.2006.09.25.19.24.12;
        Mon, 25 Sep 2006 19:24:13 -0700 (PDT)
User-Agent: Microsoft-Entourage/11.2.1.051004
Date:	Tue, 26 Sep 2006 11:24:06 +0900
Subject: FW: [PATCH] cleanup hardcoding __pa/__va macros etc. (take-2)
From:	girish <girishvg@gmail.com>
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:	girish <girishvg@gmail.com>
Message-ID: <C13EBE56.724F%girishvg@gmail.com>
Thread-Topic: [PATCH] cleanup hardcoding __pa/__va macros etc. (take-2)
Thread-Index: AcbhEptu2kUULU0FEdulewATIGIqNAAADuYZ
In-Reply-To: <C13EBDF2.724C%girishvg@gmail.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
Return-Path: <girishvg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: girishvg@gmail.com
Precedence: bulk
X-list: linux-mips


------ Forwarded Message
From: girish <girishvg@gmail.com>
Date: Tue, 26 Sep 2006 11:22:26 +0900
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: "linux-mips@linux-mips.org" <git-commits@linux-mips.org>
Conversation: [PATCH] cleanup hardcoding __pa/__va macros etc. (take-2)
Subject: Re: [PATCH] cleanup hardcoding __pa/__va macros etc. (take-2)



The idea is to differentiate the Kseg0/Kseg1 segments in the physical area.
Beyond these areas lies the mapped area (or the HIGHMEM). What complicates
this matter further is their overlapping nature. The __pa()/__va() treated
all addresses mapped into PAGE_OFFSET (8000_0000) area. The effort is to
correctly differentiate these areas.

I could not think of any better solution & the only simplification I came up
with -

#ifdef CONFIG_32BIT
/* 8000_0000 & above */
#define ISMAPPEDPA(x)   ((x) > KSEG0)
/* below 2000_0000 */
#define ISUNMAPPEDVA(x) ((x) < HIGHMEM_START)
#else
#define ISMAPPEDPA(x)   (1)
#define ISMAPPEDVA(x)   (1)
#endif

#define ___pa(x)        ((unsigned long) (x) - KSEGX((x)))
#define __pa(x)         (ISUNMAPPEDPA(x) ? ___pa((x)) : (x))

#define ___va(x)        ((void *)((unsigned long) (x) + KSEG0))
#define __va(x)         (ISUNMAPPEDVA(x) ? ___va((x)) : (x))


On 9/26/06 12:43 AM, "Atsushi Nemoto" <anemo@mba.ocn.ne.jp> wrote:

> On Mon, 25 Sep 2006 23:51:46 +0900, girish <girishvg@gmail.com> wrote:
>> Here is the patch again, attached as a text file. I don't have idea how
>> these macros should be on a 64bit machine, so I just left them as it is.
>> Could you please verify these macros again?
> 
> Well, I should ask first: Why do you change __pa() and __va() ?
> 
> I can not see point of ISMAPPED() testing.  And these macros are used
> quite often so they should be as fast as possible.
> 
> ---
> Atsushi Nemoto

------ End of Forwarded Message
