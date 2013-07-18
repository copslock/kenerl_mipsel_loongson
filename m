Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jul 2013 22:26:13 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:10888 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823426Ab3GRU0HWzGtU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jul 2013 22:26:07 +0200
X-Authority-Analysis: v=2.0 cv=e9yEuNV/ c=1 sm=0 a=Sro2XwOs0tJUSHxCKfOySw==:17 a=Drc5e87SC40A:10 a=m81s-13gt9IA:10 a=5SG0PmZfjMsA:10 a=IkcTkHD0fZMA:10 a=meVymXHHAAAA:8 a=KGjhK52YXX0A:10 a=DHlrDtQkiHoA:10 a=VwQbUJbxAAAA:8 a=4nTBI54OEixUBHPdUOkA:9 a=QEXdDO2ut3YA:10 a=X_FumI7QcasA:10 a=8MU9W6P4Xn4A:10 a=Sro2XwOs0tJUSHxCKfOySw==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 67.255.60.225
Received: from [67.255.60.225] ([67.255.60.225:51162] helo=[192.168.23.10])
        by hrndva-oedge01.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.3.46 r()) with ESMTP
        id 9A/C6-18705-85F48E15; Thu, 18 Jul 2013 20:26:00 +0000
Message-ID: <1374179160.6458.269.camel@gandalf.local.home>
Subject: Re: [PATCH] mips/ftrace: Fix function tracing return address to
 match
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Corey Minyard <cminyard@mvista.com>,
        David Daney <david.daney@cavium.com>
Date:   Thu, 18 Jul 2013 16:26:00 -0400
In-Reply-To: <51E84CBC.80206@gmail.com>
References: <1373926637-24627-1-git-send-email-ddaney.cavm@gmail.com>
         <1374178262.6458.266.camel@gandalf.local.home> <51E84CBC.80206@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.4.4-3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
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

On Thu, 2013-07-18 at 13:14 -0700, David Daney wrote:

> There is an mcount ABI difference based on which GCC version you are 
> using, although I wouldn't think it would effect this bit.
> 
> We are using GCC-4.7 FWIW.
> 
> David Daney

I'm using 4.6.3 which I downloaded from
https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/4.6.3/

I can down load the 4.7 version and see if that makes a difference.

-- Steve
