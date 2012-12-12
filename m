Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2012 15:45:11 +0100 (CET)
Received: from smtp-out-249.synserver.de ([212.40.185.249]:1300 "EHLO
        smtp-out-249.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825735Ab2LLOpKonFCo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Dec 2012 15:45:10 +0100
Received: (qmail 29988 invoked by uid 0); 12 Dec 2012 14:45:05 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 29923
Received: from p4fe627b7.dip.t-dialin.net (HELO ?192.168.0.176?) [79.230.39.183]
  by 217.119.54.96 with AES256-SHA encrypted SMTP; 12 Dec 2012 14:45:04 -0000
Message-ID: <50C89870.5000704@metafoo.de>
Date:   Wed, 12 Dec 2012 15:45:04 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.10) Gecko/20121027 Icedove/10.0.10
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Make CP0 config registers readable via sysfs.
References: <1354858280-29576-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1354858280-29576-1-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 35261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 12/07/2012 06:31 AM, Steven J. Hill wrote:
> From: "Steven J. Hill" <sjhill@mips.com>
> 
> Allow reading of CP0 config registers via sysfs for each core
> in the system.

Maybe a stupid question, but why?

> The registers will show up in sysfs at the path:
> 
>    /sys/devices/system/cpu/cpuX/configX
> 
> Only CP0 config registers 0 through 7 are currently supported.

> 
> Signed-off-by: Steven J. Hill <sjhill@mips.com>
[...]
