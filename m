Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Oct 2010 14:29:10 +0200 (CEST)
Received: from bitwagon.com ([74.82.39.175]:55126 "HELO bitwagon.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S1491036Ab0JYM3G (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Oct 2010 14:29:06 +0200
Received: from f11-64.local ([67.171.188.169]) by bitwagon.com for <linux-mips@linux-mips.org>; Mon, 25 Oct 2010 05:28:55 -0700
Message-ID: <4CC577ED.3070708@bitwagon.com>
Date:   Mon, 25 Oct 2010 05:28:29 -0700
From:   John Reiser <jreiser@bitwagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc11 Thunderbird/3.0.4
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     wu zhangjin <wuzhangjin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: patch: [RFC 2/2] ftrace/MIPS: Add support for C version of recordmcount
References: <AANLkTinwXjLAYACUfhLYaocHD_vBbiErLN3NjwN8JqSy@mail.gmail.com> <4CC49A99.1080601@bitwagon.com> <alpine.LFD.2.00.1010250435540.15889@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.00.1010250435540.15889@eddie.linux-mips.org>
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <jreiser@bitwagon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jreiser@bitwagon.com
Precedence: bulk
X-list: linux-mips

On 10/24/2010 08:59 PM, Maciej W. Rozycki wrote:

> Search the web for SGI's "64-bit ELF Object File 
> Specification" for further details.
> 
> [I wish people read the specs and did not rely on guesswork before writing 
> code like this, sigh...]

I offered a patch.  Would you care to offer a different patch?

Give the literal URL that you intend.  Include the URL in the patch!
An actual citation (author, title, URL, date) is more valuable than
"search the web", even if the URL should be come stale.

There is more than one spec.  <elf.h> is one of them, and it is available
without searching.  It is a fault on the MIPS milieu that one must search
for the spec.  The obvious candidate after searching:
   http://techpubs.sgi.com/library/manuals/4000/007-4658-001/pdf/007-4658-001.pdf
says only "Draft version 2.5".  Was it ever adopted?  When, and by whom?
Is there a more-authoritative version?  Has it been superseded?

Patch, please?

-- 
John Reiser, jreiser@BitWagon.com
