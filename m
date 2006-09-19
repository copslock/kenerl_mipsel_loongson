Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Sep 2006 00:27:06 +0100 (BST)
Received: from w099.z064220152.sjc-ca.dsl.cnc.net ([64.220.152.99]:43680 "EHLO
	bluesmobile.corp.specifix.com") by ftp.linux-mips.org with ESMTP
	id S20038700AbWISX1E (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Sep 2006 00:27:04 +0100
Received: from localhost.localdomain (bluesmobile.specifix.com [64.220.152.99])
	by bluesmobile.corp.specifix.com (Postfix) with ESMTP id C2DB93B8A3;
	Tue, 19 Sep 2006 16:21:45 -0700 (PDT)
Subject: RE: Differing results from cross and native compilers
From:	Jim Wilson <wilson@specifix.com>
To:	Eric DeVolder <edevolder@razamicroelectronics.com>
Cc:	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
In-Reply-To: <2E96546B3C2C8B4CA739323C6058204A0163548C@hq-ex-mb01.razamicroelectronics.com>
References: <2E96546B3C2C8B4CA739323C6058204A0163548C@hq-ex-mb01.razamicroelectronics.com>
Content-Type: text/plain
Date:	Tue, 19 Sep 2006 16:22:59 -0700
Message-Id: <1158708179.22871.4.camel@dhcp-128-107-165-145.cisco.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Return-Path: <wilson@specifix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@specifix.com
Precedence: bulk
X-list: linux-mips

On Tue, 2006-09-19 at 09:57 -0700, Eric DeVolder wrote:

> -       lw      $4,%got($LC0)($28)
> +       la      $4,$LC0

The difference here is -mexplicit-relocs, which is the default for the
first one (cross) but not the second one (native).

The explicit-reloc support is enabled by a run-time configure test,
which tries to run the assembler to see if you have a new enough version
of GNU as that supports the necessary assembler reloc syntax.
Apparently this is going wrong with the native build.  Perhaps you have
a different binutils version, or perhaps there is a problem with your
PATH, or perhaps binutils and gcc weren't configured with the same
prefix, etc.

If you have the build trees, you can look at the gcc/config.h files and
note that one has HAVE_AS_EXPLICIT_RELOCS defined and the other doesn't.

-- 
Jim Wilson, GNU Tools Support, http://www.specifix.com
