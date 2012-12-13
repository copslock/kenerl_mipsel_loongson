Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Dec 2012 00:27:34 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:52033 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823110Ab2LMX1dd2Qh- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Dec 2012 00:27:33 +0100
Date:   Thu, 13 Dec 2012 23:27:33 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     "Steven J. Hill" <sjhill@mips.com>
cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v4] MIPS: Make CP0 config registers readable via sysfs.
In-Reply-To: <1355436915-24381-1-git-send-email-sjhill@mips.com>
Message-ID: <alpine.LFD.2.02.1212132325180.5950@eddie.linux-mips.org>
References: <1355436915-24381-1-git-send-email-sjhill@mips.com>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 35284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, 13 Dec 2012, Steven J. Hill wrote:

> Allow reading of CP0 config registers via sysfs for each core
> in the system. The registers will show up in sysfs at the path:
> 
>    /sys/devices/system/cpu/cpuX/configX

 You're exporting privileged context outside the kernel -- have all the 
security implications been considered?  At the very least I don't think 
these files should be word-readable.

  Maciej
