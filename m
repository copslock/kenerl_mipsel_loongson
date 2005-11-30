Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Nov 2005 15:19:34 +0000 (GMT)
Received: from amdext3.amd.com ([139.95.251.6]:21402 "EHLO amdext3.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133439AbVK3PTN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 30 Nov 2005 15:19:13 +0000
Received: from SSVLGW01.amd.com (ssvlgw01.amd.com [139.95.250.169])
	by amdext3.amd.com (8.12.11/8.12.11/AMD) with ESMTP id jAUFMYfj028965;
	Wed, 30 Nov 2005 07:22:35 -0800
Received: from 139.95.250.1 by SSVLGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Wed, 30 Nov 2005 07:22:24 -0800
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint.amd.com (8.12.8/8.12.8/AMD) with ESMTP id jAUFM4xc016304; Wed,
 30 Nov 2005 07:22:04 -0800 (PST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 410C52026; Wed, 30 Nov 2005
 08:22:04 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id jAUFTHvJ008602; Wed, 30 Nov 2005 08:29:17
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id jAUFTGLf008601; Wed, 30 Nov 2005 08:29:16
 -0700
Date:	Wed, 30 Nov 2005 08:29:16 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Matej Kupljen" <matej.kupljen@ultra.si>
cc:	"Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Fix board type in db1x00
Message-ID: <20051130152916.GI24825@cosmic.amd.com>
References: <20051122221526.GZ18119@cosmic.amd.com>
 <6dabaec28e238ccc915f20f51ee28327@embeddedalley.com>
 <20051129165148.GA20402@linux-mips.org>
 <1133339727.24526.11.camel@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <1133339727.24526.11.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F931C3A3TS346126-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

> You forgot DBAU1200.

Nope.  PB1200 and DB1200 boards do not compile au1000/db1x00/init.c  they use
au1000/pb1200/init.c instead, and said file already has the correct machine
type.

Jordan
-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
