Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 14:55:17 +0100 (BST)
Received: from nz-out-0506.google.com ([64.233.162.239]:63139 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022805AbXCZNzN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Mar 2007 14:55:13 +0100
Received: by nz-out-0506.google.com with SMTP id x7so1450194nzc
        for <linux-mips@linux-mips.org>; Mon, 26 Mar 2007 06:54:04 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s59WDD5tyIrxqLYiFVcnb5pGNkpaFybzPaJba6eszHm740/puqoK/yM3KMI7mjXp0qui8D43MHTqZtdH4PJJW2uGpu49HZ8ANdrtVnXoiJAXNBDw3xQ3mIp3k41QJaw0jH5T4beCRj4QiVTk7avGMQaUNBAToAHWcBbameXpMaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W32RqVjZ7JaC4UblMOvqc6PdHgU42ZE595oNs2r1LKdLOol9qhu2MvtzJh9If9FSX7bBKVUtTs2/hq0RQlFIAuAduXGDzXCSrdmsTKqPSMbtFrJSVhsrFmqgn2suqSXDwg+FET4WATQbd4zhjGdMwLF/5nnr05TzJw+nRmvgzBg=
Received: by 10.114.157.1 with SMTP id f1mr2642261wae.1174917243510;
        Mon, 26 Mar 2007 06:54:03 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Mon, 26 Mar 2007 06:54:03 -0700 (PDT)
Message-ID: <cda58cb80703260654u4435b90axa28507f6c9011c00@mail.gmail.com>
Date:	Mon, 26 Mar 2007 15:54:03 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
Cc:	Kumba <kumba@gentoo.org>, "Atsushi Nemoto" <anemo@mba.ocn.ne.jp>,
	linux-mips@linux-mips.org, ths@networkno.de
In-Reply-To: <20070325221919.GA12088@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070324.234727.25910303.anemo@mba.ocn.ne.jp>
	 <20070324231602.GP2311@networkno.de> <46062400.8080307@gentoo.org>
	 <20070326.011000.75185255.anemo@mba.ocn.ne.jp>
	 <4606AA74.3070907@gentoo.org> <20070325221919.GA12088@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

On 3/26/07, Ralf Baechle <ralf@linux-mips.org> wrote:
>
> Well, how about this solution that solve the whole thing entirely with
> Kconfig?
>

Could you explain why you don't actually like the patchset that care
about that in Kbuild ?

You were asked several times why this patchset have not been
considerated without any answers. So I have no clue why it's broken.

And now we have a third (well at least) solution... and I don't see
why it's better than Kbuild one: it still has GCC version test which
should be part of Kbuild for this case, if someone changes the kernel
load address and don't know about the new Kconfig option, then it will
still fail...

thanks for answering...
-- 
               Franck
