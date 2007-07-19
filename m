Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2007 16:16:13 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.179]:44411 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022485AbXGSPQL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jul 2007 16:16:11 +0100
Received: by py-out-1112.google.com with SMTP id p76so1137354pyb
        for <linux-mips@linux-mips.org>; Thu, 19 Jul 2007 08:16:09 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fTBfKVSOrWYc6F8Q2M0tSnIojdtllbaiIXVrdvTNlKOIOdFEle47GswL0KEEnohf6A+QxTHGoPF1YF4lPkTUsfW9gswEA3G09e3WgLLd5OWEf3SgJl5VlVInFu+3AlrencuNzHs6AEQRcWckRczxUjHaEVCUk+McyZSfVDaRcHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ozwip5JuuzvOvr8KEwEkGlzroYo4A19+eUUh+ECiKnKoo0ZpYZXazM6ByDzxpQF4XEIGfLX7TUBSRsOXBS8yG+oUvlnYbPrgdqZddfWMD2jJzlmCQaMxGziRVY77599vK95fDZopEJNcKOx3e3PA79mxLKf4ziiMKiICx1mMizM=
Received: by 10.64.76.15 with SMTP id y15mr4872706qba.1184858169243;
        Thu, 19 Jul 2007 08:16:09 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Thu, 19 Jul 2007 08:16:09 -0700 (PDT)
Message-ID: <cda58cb80707190816u3ec05063pc702d2250cfabc7@mail.gmail.com>
Date:	Thu, 19 Jul 2007 17:16:09 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH] User stack pointer randomisation
Cc:	nigel@mips.com, linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <469F5BD9.3080601@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <469F5345.5010209@innova-card.com>
	 <20070719123030.GA21934@linux-mips.org>
	 <469F5BD9.3080601@innova-card.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 7/19/07, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>         if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)

actually this condition can be replaced by this simpler one:

        if (current->flags & PF_RANDOMIZE)

since PF_RANDOMIZE flag is raised if and only if the old condition is true.

At this point do you prefer a patch to amend these modifications or to
replace the old one ?

Sorry for the annoyance.
-- 
               Franck
