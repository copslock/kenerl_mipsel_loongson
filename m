Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Dec 2004 17:26:45 +0000 (GMT)
Received: from coderock.org ([IPv6:::ffff:193.77.147.115]:221 "EHLO
	trashy.coderock.org") by linux-mips.org with ESMTP
	id <S8225263AbULYRZH>; Sat, 25 Dec 2004 17:25:07 +0000
Received: by trashy.coderock.org (Postfix, from userid 780)
	id 907971F12A; Sat, 25 Dec 2004 18:24:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id 6BA861F124;
	Sat, 25 Dec 2004 18:24:54 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id 1063A1F123;
	Sat, 25 Dec 2004 18:24:49 +0100 (CET)
Subject: [patch 4/9] delete unused file
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, domen@coderock.org
From: domen@coderock.org
Date: Sat, 25 Dec 2004 18:24:59 +0100
Message-Id: <20041225172449.1063A1F123@trashy.coderock.org>
Return-Path: <domen@coderock.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen@coderock.org
Precedence: bulk
X-list: linux-mips


Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj/include/asm-mips/it8172/it8172_lpc.h |   29 -----------------------------
 1 files changed, 29 deletions(-)

diff -L include/asm-mips/it8172/it8172_lpc.h -puN include/asm-mips/it8172/it8172_lpc.h~remove_file-include_asm_mips_it8172_it8172_lpc.h /dev/null
--- kj/include/asm-mips/it8172/it8172_lpc.h
+++ /dev/null	2004-12-24 01:21:08.000000000 +0100
@@ -1,29 +0,0 @@
-/*
- *
- * BRIEF MODULE DESCRIPTION
- *	IT8172 system controller defines.
- *
- * Copyright 2000 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
_
