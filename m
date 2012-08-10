Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Aug 2012 12:39:15 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:38793 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903683Ab2HJKjG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Aug 2012 12:39:06 +0200
Message-ID: <5024E492.5030209@phrozen.org>
Date:   Fri, 10 Aug 2012 12:38:10 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: init module specific mips_hi16_list to NULL
References: <20120810103334.GA1263@hades>
In-Reply-To: <20120810103334.GA1263@hades>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

On 10/08/12 12:33, Tony Wu wrote:
> MIPS: init module specific mips_hi16_list to NULL
> 
> mips_hi16_list was moved from global to mod_arch_specific. While
> global, it was bss initialized automatically, when moved to
> mod_arch_specific, we have to do the zero initialization.
> 
> Signed-off-by: Tony Wu <tung7970@gmail.com>


Hi Tony,

can you reference the offending commit that caused the regression inside
the patches description please ...

John
