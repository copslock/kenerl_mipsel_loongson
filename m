Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2006 17:02:08 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.189]:28351 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037475AbWJKQCG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Oct 2006 17:02:06 +0100
Received: by nf-out-0910.google.com with SMTP id a25so223993nfc
        for <linux-mips@linux-mips.org>; Wed, 11 Oct 2006 09:02:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=PSJBvHC2my3afVf/GQhRN+6etBTvRrnukS/UIQFVwV6Hpip/oF7sTS6jRfbB6pFNviiPLFfmqKGvOTP2LgYEt49Df+2Mc5t+uMT3zSx7orubhIoUbfW4F6mSdZX2qPNZkqP88Xfek3l82xN/9/1kkNHI5BbBmSEKq9TeDQrpFoI=
Received: by 10.49.41.18 with SMTP id t18mr3490816nfj;
        Wed, 11 Oct 2006 09:01:51 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id o9sm301548nfa.2006.10.11.09.01.50;
        Wed, 11 Oct 2006 09:01:50 -0700 (PDT)
Message-ID: <452D1567.1050706@innova-card.com>
Date:	Wed, 11 Oct 2006 18:01:43 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, ralf@linux-mips.org, ths@networkno.de,
	linux-mips@linux-mips.org, fbuihuu@gmail.com
Subject: Re: [PATCH 1/5] Make __pa() uses CPHYSADDR() if really needed
References: <11605685251014-git-send-email-fbuihuu@gmail.com>	<20061011.223352.126573442.anemo@mba.ocn.ne.jp>	<452CFC95.1080806@innova-card.com> <20061012.003007.08076055.anemo@mba.ocn.ne.jp>
In-Reply-To: <20061012.003007.08076055.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> Here's my understanding.
> 
> CPHYSADDR --- used to convert a CKSEG0 or CKSEG1 to a physical
> address.  Be carefull when use it in 64-bit kernel.
> 
> __pa() --- inverse of __va(), of course :-) used to convert a kernel
> linear logical address to a physycal address.
> 
> virt_to_phys() --- synonym of __pa() ?

Well in my understanding __pa() is used during bootmem init. It deals with
initialisation issues and ugliness and that's what CPHYSADDR() actually
does. virt_to_phys() is used once everything is correctly setup.

> __pa() is used in many place indirectly via virt_to_page().
> 

what about make virt_to_page() use virt_to_phys() instead ?

		Franck
