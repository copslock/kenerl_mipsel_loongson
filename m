Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2004 19:57:50 +0000 (GMT)
Received: from adsl-66-123-66-42.dsl.pltn13.pacbell.net ([IPv6:::ffff:66.123.66.42]:13709
	"EHLO stella-blue.herbertphamily.com") by linux-mips.org with ESMTP
	id <S8225470AbUAOT5p>; Thu, 15 Jan 2004 19:57:45 +0000
Received: from [192.168.1.8] (shakedown.herbertphamily.com [192.168.1.8])
	(authenticated bits=0)
	by stella-blue.herbertphamily.com (8.12.8/8.12.8) with ESMTP id i0FJvg0M008394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 15 Jan 2004 11:57:43 -0800
Subject: Re: [PATCH 2.6] DEBUG_INFO, KGDB and etc...
From: Kevin Paul Herbert <kph@cisco.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <20040115112201.E18368@mvista.com>
References: <20040115112201.E18368@mvista.com>
Content-Type: text/plain
Organization: cisco Systems, Inc.
Message-Id: <1074196652.24675.28.camel@shakedown>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Jan 2004 11:57:35 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <kph@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kph@cisco.com
Precedence: bulk
X-list: linux-mips

In the top level makefile, there is already:

	ifdef CONFIG_DEBUG_INFO
	CFLAGS		+= -g
	endif

I don't see why you need to add it to arch/mips/Makefile. Your Kconfig
changes seem fine though.

Kevin

On Thu, 2004-01-15 at 11:22, Jun Sun wrote:
> This patch adds the missing "-g" gcc option when kgdb is configure.
> Clean up some debugging related options (DEBUG_INFO really should
> go under KGDB and depends its not being selected)
> 
> If no objection, will check it in later.
> 
> And yes, the good news is that kgdb works in 2.6.
> 
> Jun
-- 
Kevin Paul Herbert <kph@cisco.com>
cisco Systems, Inc.
