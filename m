Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2008 16:59:43 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:22466 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28603703AbYCFQ7l (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Mar 2008 16:59:41 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m26GxeQ6021242;
	Thu, 6 Mar 2008 16:59:40 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m26Gxdl2021241;
	Thu, 6 Mar 2008 16:59:39 GMT
Date:	Thu, 6 Mar 2008 16:59:39 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Laird <daniel.j.laird@nxp.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] : Move arch/mips/philips to arch/mips/nxp
Message-ID: <20080306165939.GB16365@linux-mips.org>
References: <64660ef00803060107m16fb4a4uc0153ea3c6658b8f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64660ef00803060107m16fb4a4uc0153ea3c6658b8f@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 06, 2008 at 09:07:18AM +0000, Daniel Laird wrote:
> From: Daniel Laird <daniel.j.laird@nxp.com>
> Date: Thu, 6 Mar 2008 09:07:18 +0000
> To: linux-mips@linux-mips.org
> Subject: [PATCH] : Move arch/mips/philips to arch/mips/nxp
> Content-Type: text/plain; charset=ISO-8859-1
> 
>  The following patch moves arch/mips/philips to arch/mips/nxp along
>  with the supporting changes:
>  This is required before I can start posting new chipset support.

There were still a few lines which got linewrapped but that was fortunately
manually fixable.

> @@ -887,7 +887,7 @@
>  	case CPU_SR71000:	name = "Sandcraft SR71000"; break;
>  	case CPU_BCM3302:	name = "Broadcom BCM3302"; break;
>  	case CPU_BCM4710:	name = "Broadcom BCM4710"; break;
> -	case CPU_PR4450:	name = "Philips PR4450"; break;
> +	case CPU_PR4450:	name = "NXP PR4450"; break;
>  	case CPU_LOONGSON2:	name = "ICT Loongson-2"; break;
>  	default:
>  		BUG();

The string changed is returned in /proc/cpuinfo so any change has a
chance of breaking applications.  I know, you'd like to remove the Philips
name but ...  So I applied your patch except this one segment.

  Ralf
