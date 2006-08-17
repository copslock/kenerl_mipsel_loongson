Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2006 22:20:42 +0100 (BST)
Received: from mms2.broadcom.com ([216.31.210.18]:41483 "EHLO
	mms2.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S20037641AbWHQVUk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 17 Aug 2006 22:20:40 +0100
Received: from 10.10.64.154 by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Thu, 17 Aug 2006 14:20:08 -0700
X-Server-Uuid: D9EB6F12-1469-4C1C-87A2-5E4C0D6F9D06
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 9F2832AF; Thu, 17 Aug 2006 14:20:08 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 7D91D2AE for
 <linux-mips@linux-mips.org>; Thu, 17 Aug 2006 14:20:08 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id ECV70819; Thu, 17 Aug 2006 14:20:08 -0700 (PDT)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 3A0E520501 for <linux-mips@linux-mips.org>; Thu, 17 Aug 2006 14:20:08
 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [MIPS] SB1: Build fix: delete initialization of
 flush_icache_page pointer.
Date:	Thu, 17 Aug 2006 14:20:07 -0700
Message-ID: <7E000E7F06B05C49BDBB769ADAF44D07EEEC8C@NT-SJCA-0750.brcm.ad.broadcom.com>
In-Reply-To: <S20037884AbWHMBM7/20060813011259Z+2871@ftp.linux-mips.org>
Thread-Topic: [MIPS] SB1: Build fix: delete initialization of
 flush_icache_page pointer.
Thread-Index: Aca+daILnSOlGluWQ7Srz0r4G3TUegDzPiqg
From:	"Mark E Mason" <mark.e.mason@broadcom.com>
To:	linux-mips@linux-mips.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006081712; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413031303230322E34344534444341352E303034302D412D;
 ENG=IBF; TS=20060817212012; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006081712_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 68FA02020X84194092-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.e.mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello all,

FYI:

The sb1_flash_icache_page change below breaks causes 1480 kernels to
hang after freeing memory:

[4294675.358000] Looking up port of RPC 100003/2 on 192.168.0.151

[4294675.360000] Looking up port of RPC 100005/1 on 192.168.0.151

[4294675.578000] VFS: Mounted root (nfs filesystem) readonly.

[4294675.579000] Freeing unused kernel memory: 212k freed           

The console still echos return characters, but booting doesn't progress
beyond this point.

Right before this change, everything appears to be ok.

/Mark

> -----Original Message-----
> From: linux-git-patches-bounce@linux-mips.org 
> [mailto:linux-git-patches-bounce@linux-mips.org] On Behalf Of 
> linux-mips@linux-mips.org
> Sent: Saturday, August 12, 2006 6:13 PM
> To: git-commits@linux-mips.org
> Subject: [MIPS] SB1: Build fix: delete initialization of 
> flush_icache_page pointer.
> 
> Author: Ralf Baechle <ralf@linux-mips.org> Sun Aug 13 
> 02:00:02 2006 +0100
> Commit: d95bc28e8c0bc1c39ef300ec2bca6ce99245cb50
> Gitweb: http://www.linux-mips.org/g/linux/d95bc28e
> Branch: master
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> ---
> 
>  arch/mips/mm/c-sb1.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/mm/c-sb1.c b/arch/mips/mm/c-sb1.c
> index 5df454e..4bd9ad8 100644
> --- a/arch/mips/mm/c-sb1.c
> +++ b/arch/mips/mm/c-sb1.c
> @@ -520,7 +520,6 @@ #endif
>  
>  	/* These routines are for Icache coherence with the Dcache */
>  	flush_icache_range = sb1_flush_icache_range;
> -	flush_icache_page = sb1_flush_icache_page;
>  	__flush_icache_page = sb1_flush_icache_page;
>  	flush_icache_all = __sb1_flush_icache_all; /* local only */
>  
> 
> 
> 
