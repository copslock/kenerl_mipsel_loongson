Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2003 06:55:36 +0100 (BST)
Received: from ftp-xb.sasken.com ([IPv6:::ffff:164.164.56.3]:43710 "EHLO
	sandesha.sasken.com") by linux-mips.org with ESMTP
	id <S8225197AbTDCFzf>; Thu, 3 Apr 2003 06:55:35 +0100
Received: from sunsv2.sasken.com (localhost [127.0.0.1])
	by sandesha.sasken.com (8.12.8/8.12.8) with ESMTP id h335tJNw021816
	for <linux-mips@linux-mips.org>; Thu, 3 Apr 2003 11:25:19 +0530 (IST)
Received: from pcz-madhavis.sasken.com (IDENT:madhavis@pcz-madhavis.sasken.com [10.1.64.210])
	by sunsv2.sasken.com (8.11.6/8.11.6) with ESMTP id h335tSY28475
	for <linux-mips@linux-mips.org>; Thu, 3 Apr 2003 11:25:28 +0530 (IST)
Date: Thu, 3 Apr 2003 11:25:28 +0530 (IST)
From: Madhavi <madhavis@sasken.com>
To: <linux-mips@linux-mips.org>
Subject: Relocation overflow problem with MIPS
Message-ID: <Pine.LNX.4.33.0304031124100.24014-100000@pcz-madhavis.sasken.com>
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="=_IS_MIME_Boundary"
Return-Path: <madhavis@sasken.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: madhavis@sasken.com
Precedence: bulk
X-list: linux-mips

--=_IS_MIME_Boundary
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33.0304031124102.24014@pcz-madhavis.sasken.com>


Hi

I am working on a device driver software for linux kernel version 2.4.19.
My driver is a loadable module and the size of the module executable is
approximately 1.4MB.

When I tried to load this module on x86, I didn't have any problems while
installing it. On MIPS (R5432) CPU, this is giving the following problems:

edge_mod.o: Relocation overflow of type 4 for printk
edge_mod.o: Relocation overflow of type 4 for printk
edge_mod.o: Relocation overflow of type 4 for printk
edge_mod.o: Relocation overflow of type 4 for alloc_etherdev
edge_mod.o: Relocation overflow of type 4 for printk
edge_mod.o: Relocation overflow of type 4 for printk
edge_mod.o: Relocation overflow of type 4 for pci_enable_device
edge_mod.o: Relocation overflow of type 4 for pci_set_dma_mask
edge_mod.o: Relocation overflow of type 4 for printk
edge_mod.o: Relocation overflow of type 4 for pci_find_capability
.........................

Could anyone tell me what this problem could be? What is relocation
overflow of type 4? Where can I find the list of all the possible
relocation overflow types and their descriptions?

My module is not compiled using the options -fPIC. Would it make any
difference if I enable this option?

I have seen this following comment in modutils-2.4.12/obj/obj_mips.c

/* _gp_disp is a magic symbol for PIC which is not supported for
   the kernel and loadable modules.  */

So, I was thinking that -fPIC wouldn't help much. Am I right?

Any help in this regard would be greatly appreciated.

Thank you in advance.

regards
Madhavi.

Madhavi Suram
Software Engineer
Customer Delivery / Networks
Sasken Communication Technologies Limited
139/25, Ring Road, Domlur
Bangalore - 560071 India
Email: madhavis@sasken.com
Tel: + 91 80 5355501 Extn: 8062
Fax: + 91 80 5351133
URL: www.sasken.com


--=_IS_MIME_Boundary
Content-Type: text/plain;charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

************************************************************************

Sasken Business Disclaimer

This  message may  contain  confidential,  proprietary  or  legally privileged  information. In  case  you are not the original intended recipient of the message, you must not, directly or indirectly, use,  disclose,  distribute,  print,  or copy  any  part of  this  message and you are requested to delete it and inform the sender. Any views  expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken accepts no liability for any loss or damage, which may be caused by viruses.

***********************************************************************

--=_IS_MIME_Boundary--
