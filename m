Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2003 16:48:19 +0100 (BST)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:11330 "EHLO
	avtrex.com") by linux-mips.org with ESMTP id <S8225427AbTJTPsN>;
	Mon, 20 Oct 2003 16:48:13 +0100
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 20 Oct 2003 08:48:04 -0700
Message-ID: <3F9403B4.3030207@avtrex.com>
Date: Mon, 20 Oct 2003 08:48:04 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Kesselring <dkesselr@mmc.atmel.com>
CC: linux-mips@linux-mips.org
Subject: Re: kernel modules
References: <Pine.GSO.4.44.0310201029090.12930-100000@ares.mmc.atmel.com>
In-Reply-To: <Pine.GSO.4.44.0310201029090.12930-100000@ares.mmc.atmel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Oct 2003 15:48:04.0544 (UTC) FILETIME=[8C9ED400:01C39721]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

David Kesselring wrote:

>Can someone please confirm that loading and unloading of kernel modules is
>functioning in the  2.4 release?
>
>When I try to load a wlan module that I compiled (with mipsel-*) I get
>relocation errors. I used the same options as I did to compile the kernel
>(for MIPS Malta board). If you have any ideas, please let me know.
>
>  
>
Works for me.

Using gcc 3.3.1 to compile modules, I had to upgrade to modutils-2.4.25 
and apply this patch to them:


On Thu, 16 Oct 2003 14:09:24 -0700, 
David Daney <ddaney@avtrex.com> wrote:

>>Anyhow, I encountered a small problem trying to load a module compiled 
>>with gcc-3.3.1.  The module has dwarf debugging info and could not be 
>>loaded by insmod.  This patch causes MIPS_DWARF sections to be treated 
>>in the same manner as MIPS_DEBUG sections.
>>
>>Also there was a fall through in the case statement that caused error 
>>messages to be printed twice for "Unhandled section header type".
>  
>

Thanks.   I already have an equivalent patch in my development tree
(from Alvaro Martinez Echevarria).  It is waiting for me to get some
time to release modutils 2.4.26.

Index: 25.5/obj/obj_mips.c
--- 25.5/obj/obj_mips.c Fri, 01 Mar 2002 11:39:06 +1100 kaos (modutils-2.4/c/10_obj_mips.c 1.4 644)
+++ 26.2(w)/obj/obj_mips.c Sat, 05 Apr 2003 08:36:33 +1000 kaos (modutils-2.4/c/10_obj_mips.c 1.5 644)
@@ -74,7 +74,8 @@ arch_load_proc_section(struct obj_sectio
     {
     case SHT_MIPS_DEBUG:
     case SHT_MIPS_REGINFO:
-      /* Actually these two sections are as useless as something can be ...  */
+    case SHT_MIPS_DWARF:
+      /* Ignore debugging sections  */
       sec->contents = NULL;
       break;
 
@@ -83,10 +84,10 @@ arch_load_proc_section(struct obj_sectio
     case SHT_MIPS_GPTAB:
     case SHT_MIPS_UCODE:
     case SHT_MIPS_OPTIONS:
-    case SHT_MIPS_DWARF:
     case SHT_MIPS_EVENTS:
       /* These shouldn't ever be in a module file.  */
       error("Unhandled section header type: %08x", sec->header.sh_type);
+      return -1;
 
     default:
       /* We don't even know the type.  This time it might as well be a

David Daney
