Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jan 2007 16:06:51 +0000 (GMT)
Received: from ag-out-0708.google.com ([72.14.246.250]:58945 "EHLO
	ag-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20038614AbXA2QGr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Jan 2007 16:06:47 +0000
Received: by ag-out-0708.google.com with SMTP id 22so1212886agd
        for <linux-mips@linux-mips.org>; Mon, 29 Jan 2007 08:06:40 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q2CkatFZg55WHnlVT/Cr328ps4dPmGPWcj2XUScCwipITyz0OA3iuw8sjZ3piYGg/wqHEVCIfsTLhbDcnA8WZ3Cefso/FTNY57dGi+/eAyTmn4TFKO04Hy19pyjgJUX4wcn6X0dpgyu6N0zqY9foZFpO8x8ti2dGyONA67PxGv8=
Received: by 10.90.68.15 with SMTP id q15mr6851831aga.1170086799843;
        Mon, 29 Jan 2007 08:06:39 -0800 (PST)
Received: by 10.90.34.12 with HTTP; Mon, 29 Jan 2007 08:06:39 -0800 (PST)
Message-ID: <cda58cb80701290806p5d68ba5ck5e3e3b2b3490126f@mail.gmail.com>
Date:	Mon, 29 Jan 2007 17:06:39 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Daniel Jacobowitz" <dan@debian.org>
Subject: Re: RFC: Sentosa boot fix
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070129155253.GA2070@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070128180807.GA18890@nevyn.them.org>
	 <cda58cb80701290159m5eed331em5945eac4a602363a@mail.gmail.com>
	 <20070129155253.GA2070@nevyn.them.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 1/29/07, Daniel Jacobowitz <dan@debian.org> wrote:
> On Mon, Jan 29, 2007 at 10:59:37AM +0100, Franck Bui-Huu wrote:
> > In my understanding, if your kernel is linked at 0xffffffff80xxxxxx,
> > you shouldn't have CONFIG_BUILD_ELF64 set.
>
> What Maciej said.  But also: please compare the description of
> CONFIG_BUILD_ELF64 with the targets that link at that address.
> Almost every supported target links at that address, except for
> IP27.  How do any of them work today?
>

Surely because none of them define CONFIG_BUILD_ELF64:

        $ git grep BUILD_ELF arch/mips/configs
        arch/mips/configs/bigsur_defconfig:# CONFIG_BUILD_ELF64 is not set
        arch/mips/configs/ip27_defconfig:# CONFIG_BUILD_ELF64 is not set
        arch/mips/configs/ip32_defconfig:# CONFIG_BUILD_ELF64 is not set
        arch/mips/configs/ocelot_c_defconfig:# CONFIG_BUILD_ELF64 is not set
        arch/mips/configs/ocelot_g_defconfig:# CONFIG_BUILD_ELF64 is not set
        arch/mips/configs/sb1250-swarm_defconfig:# CONFIG_BUILD_ELF64 is not set

-- 
               Franck
