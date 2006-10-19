Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 10:54:09 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.184]:33878 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20021285AbWJSJyH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 10:54:07 +0100
Received: by nf-out-0910.google.com with SMTP id g2so1040787nfe
        for <linux-mips@linux-mips.org>; Thu, 19 Oct 2006 02:54:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=c4GIYHgKzeM6LdoaGfrpB+E5MJ9YzchMAaAdC3SwNitlDh1rk1OrXKHLwxWqRehTDxyjPK2xa/GZ1P2vyJ0MPUWwD3H1KoOe9gbWJB+bpRXooSBzmFMcLkX42ZPYduHM9MEvSahgGBxXVQLzVJ2UPuD5ihZ53TUcOdtghgGI8cY=
Received: by 10.49.8.15 with SMTP id l15mr5527084nfi;
        Thu, 19 Oct 2006 02:54:04 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id h1sm641698nfe.2006.10.19.02.54.04;
        Thu, 19 Oct 2006 02:54:04 -0700 (PDT)
Message-ID: <45374B41.6060008@innova-card.com>
Date:	Thu, 19 Oct 2006 11:54:09 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, ralf@linux-mips.org, ths@networkno.de,
	linux-mips@linux-mips.org, fbuihuu@gmail.com
Subject: Re: [PATCH 6/7] setup.c: clean up initrd related code
References: <1160743146503-git-send-email-fbuihuu@gmail.com>	<20061019.131352.41630930.nemoto@toshiba-tops.co.jp>	<453739B2.1010705@innova-card.com> <20061019.181508.15248454.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20061019.181508.15248454.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Thu, 19 Oct 2006 10:39:14 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>> BTW, what about this condition:
>>
>> 		if (initrd_start < PAGE_OFFSET) {
>> 			...;
>> 		}
>>
>> that would work even on 32 bits kernel.
> 
> This does not work if PAGE_OFFSET was 0xffffffff80000000 and
> initrd_start was 0x980000000XXXXXXX :-)
> 

I think we should terminate this patch pretty quickly because
it's going to make me mad ;)

How can PAGE_OFFSET be in CKSEG0 segment and initrd_start be
in XKPHYS ?

With the current code we can say:

  - If PAGE_OFFSET is in CKSEG0, that means that all kernel
    virtual address must be in CKSEG0.
  - If PAGE_OFFSET is in XKPHYS, that means that _after_ booting
    process all kernel virtual address will be in XKPHYS. But we
    allow CKSEG0 virtual address during boot for the reasons
    we know.

What woud give __pa(initrd_start) in your example ?

__pa(initrd_start) -> 0x980000000XXXXXXX - 0xffffffff80000000

which is wrong...Does your example come from a real use case ?

		Franck
