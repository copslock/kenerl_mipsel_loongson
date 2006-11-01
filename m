Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2006 04:17:36 +0000 (GMT)
Received: from alpha.total-knowledge.com ([205.217.158.170]:35774 "EHLO
	total-knowledge.com") by ftp.linux-mips.org with ESMTP
	id S20037602AbWKAERe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Nov 2006 04:17:34 +0000
Received: (qmail 31997 invoked from network); 31 Oct 2006 20:17:29 -0800
Received: from unknown (HELO ?192.168.0.236?) (ilya@209.157.142.202)
  by alpha.total-knowledge.com with ESMTPA; 31 Oct 2006 20:17:29 -0800
Message-ID: <45481FD5.3080302@total-knowledge.com>
Date:	Tue, 31 Oct 2006 20:17:25 -0800
From:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To:	Kaz Kylheku <kaz@zeugmasystems.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Cannot run N32 binaries.
References: <66910A579C9312469A7DF9ADB54A8B7D44D290@exchange.ZeugmaSystems.local>
In-Reply-To: <66910A579C9312469A7DF9ADB54A8B7D44D290@exchange.ZeugmaSystems.local>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips

Could be looking for non-existant ld.so.1 (do you have N32 version of it
in /lib32?)

Kaz Kylheku wrote:
> Before I start debugging this, I thought I'd poll the mailing list.
>
> I've built an N32 root filesystem: all binaries and libs are "ELF 32-bit
> N32 MSB MIPS-III ..."
>
> The kernel (2.6.17.7, 64 bit) that I built does have:
>
> CONFIG_MIPS32_N32=y
>
> The filesystem doesn't boot: init cannot be found.
>  
> I copied the N32 filesystem into a subdirectory of an O32 filesystem in
> order to have a look.
>
> Basically, for any executable that I try to run, the error is: "No such
> file or directory".
>
>   

-- 
Ilya A. Volynets-Evenbakh
Total Knowledge. CTO
http://www.total-knowledge.com
