Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jun 2004 19:13:54 +0100 (BST)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:5200 "EHLO avtrex.com")
	by linux-mips.org with ESMTP id <S8225467AbUFKSNu>;
	Fri, 11 Jun 2004 19:13:50 +0100
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 11 Jun 2004 11:11:39 -0700
Message-ID: <40C9F5FE.8030607@avtrex.com>
Date: Fri, 11 Jun 2004 11:12:14 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: [Patch]  / 0 should send SIGFPE not SIGTRAP...
References: <40C9F5A4.2050606@avtrex.com>
In-Reply-To: <40C9F5A4.2050606@avtrex.com>
Content-Type: multipart/mixed;
 boundary="------------030201060104070501020203"
X-OriginalArrivalTime: 11 Jun 2004 18:11:39.0477 (UTC) FILETIME=[8A988850:01C44FDF]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------030201060104070501020203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

It might help if I attached the patch.  Here it is...

David Daney wrote:

> I am getting a SIGTRAP whenever an integer divide by 0 happens.  It 
> should be sending SIGFPE.
>
> It looks like kernel/traps.c is a little messed up.
>
> The attached patch fixes it for me.
>
> The decoding of the break instruction was selecting the wrong bits.  
> It looks like the trap instruction decoding was messed up also.  The 
> patch fixes trap also, but I could not figure out how to get gcc to 
> generate the trap form of division, so that part is untested.
>
> David Daney.
>


--------------030201060104070501020203
Content-Type: text/plain;
 name="traps.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="traps.diff"

--- ../linux-avtrex/linux/arch/mips/kernel/traps.c	2004-02-26 11:14:09.000000000 -0800
+++ arch/mips/kernel/traps.c	2004-06-11 10:13:59.000000000 -0700
@@ -598,7 +598,7 @@
 	 * code starts left to bit 16 instead to bit 6 in the opcode.
 	 * Gas is bug-compatible ...
 	 */
-	bcode = ((opcode >> 16) & ((1 << 20) - 1));
+	bcode = ((opcode >> 6) & ((1 << 20) - 1));
 
 	/*
 	 * (A short test says that IRIX 5.3 sends SIGTRAP for all break
@@ -633,7 +633,7 @@
 
 	/* Immediate versions don't provide a code.  */
 	if (!(opcode & OPCODE))
-		tcode = ((opcode >> 6) & ((1 << 20) - 1));
+		tcode = ((opcode >> 6) & ((1 << 10) - 1));
 
 	/*
 	 * (A short test says that IRIX 5.3 sends SIGTRAP for all trap

--------------030201060104070501020203--
