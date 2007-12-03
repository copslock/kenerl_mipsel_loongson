Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Dec 2007 21:46:43 +0000 (GMT)
Received: from mu-out-0910.google.com ([209.85.134.189]:60218 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022417AbXLCVqf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Dec 2007 21:46:35 +0000
Received: by mu-out-0910.google.com with SMTP id g7so9619muf
        for <linux-mips@linux-mips.org>; Mon, 03 Dec 2007 13:46:23 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=GCNBWdof0iUVH/lrTlVLb6vunE0XhVT9ja2HGx3LYws=;
        b=fG1XodbWuT2sELPxwuxEUzysnG29L3Ms1Q2KOWG0uJblMt+y2jQAJ8BZIkDEIGryqVY5Ijh/E9lWraemLk5IRRXSfTSbEEyJZ7Tn5I66t1tGAVSdaYNETFDoXtJ8kRSRKjNpTy9vp4+Seof9CK9xMTa/SHS4dQ7MHccIo/ImtZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=M3q+dqvHWhdI3F7YWDweNND2G87weB69lm8jduMMSWWvaUVi94uOdtBVnPr6GK7EENAYY9n0wWdYPY4hT2up5CMHHmujYPwIGOZPzbAajTQZhhMesRnp0Kb7DkRxslLwQtNgP1GGq/+SpAubdU4C7KFvrsvy/59Qa7oEaVrTsFo=
Received: by 10.86.73.17 with SMTP id v17mr5088022fga.1196718382718;
        Mon, 03 Dec 2007 13:46:22 -0800 (PST)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id 4sm6478517fge.2007.12.03.13.46.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Dec 2007 13:46:22 -0800 (PST)
Message-ID: <47547926.5060806@gmail.com>
Date:	Mon, 03 Dec 2007 22:46:14 +0100
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	"Luck, Tony" <tony.luck@intel.com>
CC:	linux-arch@vger.kernel.org, macro@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: vmlinux.lds.S: handle .{init,exit}.bss sections
References: <1196543586-6698-1-git-send-email-fbuihuu@gmail.com> <1196543586-6698-3-git-send-email-fbuihuu@gmail.com> <617E1C2C70743745A92448908E030B2A030FE4C2@scsmsx411.amr.corp.intel.com>
In-Reply-To: <617E1C2C70743745A92448908E030B2A030FE4C2@scsmsx411.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Luck, Tony wrote:
> +	/*
> +	 * We keep init/exit bss sections here to have only one
> +	 * segment to load. Note that .bss.exit is also discarded
> +	 * at runtime for the same reason as above.
> +	 */
> +	.exit.bss : {
> +		*(.bss.exit)
> +	}
> 
> This change would also require an audit of the bootloader or early
> kernel initialization code (whichever handles zeroing of .bss space)

I think the kernel doesn't rely on the bootloader for clearing bss.

> to make sure that it understands that the kernel will now have an
> extra block of memory that needs to be cleared.  Perhaps nothing
> needs to be done if the code already handled the general case of
> loading an ELF binary with some sections that have an in-memory
> size bigger than the on-disk size.  But worth looking at in case
> the code makes an assumption about what needs to be zeroed.
> 

For MIPS case, there is normally no extra block of memory to
clear. [__bss_start, __bss_stop] range still includes the whole memory
block to clear. So there's no need to modify any other code.

		Franck
