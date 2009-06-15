Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jun 2009 18:01:40 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1530 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492630AbZFOQBf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 15 Jun 2009 18:01:35 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a366ff80000>; Mon, 15 Jun 2009 11:59:52 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 15 Jun 2009 08:59:51 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 15 Jun 2009 08:59:51 -0700
Message-ID: <4A366FF7.2010206@caviumnetworks.com>
Date:	Mon, 15 Jun 2009 08:59:51 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Wu Zhangjin <wuzhangjin@gmail.com>
CC:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	Wang Liming <liming.wang@windriver.com>,
	Wu Zhangjin <wuzj@lemote.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH v3] filter local function prefixed by $L
References: <cover.1244994151.git.wuzj@lemote.com> <d0983eb71d7517d0e536352f3288e995abbb0e07.1244994151.git.wuzj@lemote.com>
In-Reply-To: <d0983eb71d7517d0e536352f3288e995abbb0e07.1244994151.git.wuzj@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jun 2009 15:59:51.0485 (UTC) FILETIME=[510336D0:01C9EDD2]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzj@lemote.com>
> 
> this patch fixed the warning as following:
> 
> mipsel-linux-gnu-objcopy: 'fs/proc/.tmp_gl_devices.o': No such file
> mipsel-linux-gnu-ld: fs/proc/.tmp_gl_devices.o: No such file: No such
> file or directory
> rm: cannot remove `fs/proc/.tmp_gl_devices.o': No such file or directory
> rm: cannot remove `fs/proc/.tmp_mx_devices.o': No such file or directory
> 
> the real reason of above warning is that the $Lxx local functions will
> be treated as global symbols, so, should be filtered.
> 
> Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
> ---
>  scripts/recordmcount.pl |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
> index 533d3bf..542cb04 100755
> --- a/scripts/recordmcount.pl
> +++ b/scripts/recordmcount.pl
> @@ -343,6 +343,10 @@ sub update_funcs
>  	if (!$use_locals) {
>  	    return;
>  	}
> +	# filter $LXXX tags
> +	if ("$ref_func" =~ m/\$L/) {
> +		return;
> +	}

Certainly this is true for mips.  I doubt it is for all architectures 
targed by Linux.

David Daney
