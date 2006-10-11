Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2006 17:13:22 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.184]:499 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037676AbWJKQNU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Oct 2006 17:13:20 +0100
Received: by nf-out-0910.google.com with SMTP id a25so226585nfc
        for <linux-mips@linux-mips.org>; Wed, 11 Oct 2006 09:13:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=WXxCiWx75KDA/FQPsZihsEAd7rbOc6wb7K9rKXQlXsehwHOSeqDJBWvF1OOgATvEEqC56Z9WXwMRIrbxV0HSBT2U3H6Ke1upYUt98skB8Nif6DPlGgcrdLfWZ4x0DcdXOPalwLBSsOQry3mbBGS1exmKKJwItr6HnwhGmEx+I3U=
Received: by 10.49.26.18 with SMTP id d18mr3467418nfj;
        Wed, 11 Oct 2006 09:13:08 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id o9sm323632nfa.2006.10.11.09.13.07;
        Wed, 11 Oct 2006 09:13:07 -0700 (PDT)
Message-ID: <452D180D.9020700@innova-card.com>
Date:	Wed, 11 Oct 2006 18:13:01 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, ralf@linux-mips.org, ths@networkno.de,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 4/5] Introduce __pa_symbol()
References: <1160568525897-git-send-email-fbuihuu@gmail.com>	<11605685254080-git-send-email-fbuihuu@gmail.com> <20061012.003436.130240259.anemo@mba.ocn.ne.jp>
In-Reply-To: <20061012.003436.130240259.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Wed, 11 Oct 2006 14:08:44 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>> This patch introduces __pa_symbol() macro which should be used to
>> calculate the physical address of kernel symbols. It also relies
>> on RELOC_HIDE() to avoid any compiler's oddities when doing
>> arithmetics on symbols.
> 
> I agree with you that we need __pa_symbol(), but what is a purpose of
> using RELOC_HIDE() here?  Frankly I do not understand what
> RELOC_HIDE() does...
> 

RELOC_HIDE(x) is used because arithmetic on symbol addresses is
undefined in C language. It avoid gcc to know that:

	RELOC_HIDE(&_end) + OFFSET

is an operation on a symbol address and thus avoid an undefined
operation.

		Franck
