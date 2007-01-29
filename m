Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jan 2007 09:59:44 +0000 (GMT)
Received: from ag-out-0708.google.com ([72.14.246.240]:6034 "EHLO
	ag-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20038517AbXA2J7k (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Jan 2007 09:59:40 +0000
Received: by ag-out-0708.google.com with SMTP id 22so1154699agd
        for <linux-mips@linux-mips.org>; Mon, 29 Jan 2007 01:59:37 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eio1WaHAwTOPNvbOVXpL4ga9QIExGofvPTknjxlde9w0bvjp0ncH0I6ypmz7ih/VfHtTna7fRlHJl2NgpDlhQk14cYbjp/n2YgccilO4Z4rA15Z+D53TxdV4oC+3VVZbO4hO9wUDweIOJb5nMUm2+azCPXrmjNpE9sa4CPp+8Ts=
Received: by 10.90.32.14 with SMTP id f14mr6299421agf.1170064777414;
        Mon, 29 Jan 2007 01:59:37 -0800 (PST)
Received: by 10.90.34.12 with HTTP; Mon, 29 Jan 2007 01:59:37 -0800 (PST)
Message-ID: <cda58cb80701290159m5eed331em5945eac4a602363a@mail.gmail.com>
Date:	Mon, 29 Jan 2007 10:59:37 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Daniel Jacobowitz" <dan@debian.org>
Subject: Re: RFC: Sentosa boot fix
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070128180807.GA18890@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070128180807.GA18890@nevyn.them.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On 1/28/07, Daniel Jacobowitz <dan@debian.org> wrote:
> The problem is __pa_symbol(&_end); the kernel is linked at
> 0xffffffff80xxxxxx, so subtracting a PAGE_OFFSET of 0xa800000000000000
> does not do anything useful to this address at all.
>

In my understanding, if your kernel is linked at 0xffffffff80xxxxxx,
you shouldn't have CONFIG_BUILD_ELF64 set.

-- 
               Franck
