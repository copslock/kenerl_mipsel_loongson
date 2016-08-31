Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2016 10:26:00 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.10]:63363 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991977AbcHaIZxVlKlj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Aug 2016 10:25:53 +0200
Received: from wuerfel.localnet ([176.7.54.107]) by mrelayeu.kundenserver.de
 (mreue101) with ESMTPSA (Nemesis) id 0LdmwF-1bEEvi0i3v-00j4Tr; Wed, 31 Aug
 2016 10:24:49 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] tracing/syscalls: allow multiple syscall numbers per syscall
Date:   Wed, 31 Aug 2016 10:24:56 +0200
Message-ID: <5227283.eAVLXfitJh@wuerfel>
User-Agent: KMail/5.1.3 (Linux/4.4.0-34-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <CALCETrXA0XbYuqYzWMJA+KjFS31YL0cTVtrvCnmRY_GMK6oNpw@mail.gmail.com>
References: <1472463007-6469-1-git-send-email-marcin.nowakowski@imgtec.com> <20160830152955.17633511@gandalf.local.home> <CALCETrXA0XbYuqYzWMJA+KjFS31YL0cTVtrvCnmRY_GMK6oNpw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:SFcEq3DyCBfM/Z/YPQ3/y7XtRWhG0eyNZVklT//g7xMdb4SaGyr
 TuzhQIsii6ca2yNqkmqaF8Y8yERpIKW+F0QshQ2IsNvJGoV+YUKpC/nETyyi0MWiwZX2hgi
 wY4J3oWUNou0Lmtitnh4T89ikNL1ovo3LsSXybCmPHewjvkyoyFmmMsGRSdPmhFlp/Ah2qK
 6ugJ+GeNnR503zcGfW3vw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RxanQ44ZTkk=:OyfEKSzj2PfTJzbuyGyLVp
 XWGHcgw7e6/vtpm95M/L8qp+ivm1mpuHxZbQFPJCONF5AwdkJ93f/AQVFvDc7GNpkQ8LujxBH
 N8LZsDfaoPYzfO/j5UHe9I1npnuSAFci23OPTWOxMCoIm/vZ+3J7qac0fh1H5tiGHzcYh68Qi
 aFGW7fMQU7/pcvkS3vePRlfyaVLxP+rFbkiZYHJfp0RfSVJJHYfSf475yjShY6rGyvO7EGF1b
 msquNO8Y5hhGl1nsrC8/ZgudMba8a4WfHHBAL5pz2A9gCFYo+nAiJWSiZIyHYTIWQZZxsdASD
 TLiAKdkJqxPpRtaJRxCPaDEwjTZOXgmqm69m/05MDoEDG3qNqBsTpIcKOCsKWz/5lImS39kS1
 b3Be/ojosmwcH+fgk2dEySyG4a6NkXRQScOwfp+Purcyrxzg3nzSsPaEq/WZ43j8vCBAHGJuN
 dcdcen8Hg9zHHjYtyYYlPKCKYFqpTXCdjSRc0GoIlc5kicDZmUtnN1uoMjv8dghhS31QmQ4l9
 WMP9exx7sQJ4tA8r7kzA+3Ms0l5H5B8Azy4Gm49nkBFUw6BoU0012eMSIP9KEqDQILYl1CAgJ
 rtuRcUhxDGtGU+i7fosMTEbkIDX0cLp7eTJZsCmzorTd3xangs+eG4jfu537ROoDOyPRinGZA
 LifRmopypf6FGJMejOkVnVINca0faqJlNiP8+qfc0hLTU4Gge7+qAG1PU15SiWphC9ZLQzWXy
 iWqVp1krzq1MMjLl
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Tuesday, August 30, 2016 12:53:53 PM CEST Andy Lutomirski wrote:
> Egads!  OK, I see why this is a mess.
> 
> I guess we should be creating the metadata from the syscall tables
> instead of from the syscall definitions, but I guess that's currently
> a nasty per-arch mess.
> 

I've been thinking for a while about how to improve the situation
around adding new syscalls, which currently involves adding a number
and an entry in a .S file on most architectures (some already have
their own method to simplify it, and others using a shared table
in asm-generic).

I was thinking of extending the x86 way of doing this to all
architectures, and adding a way to have all future syscalls require
only one addition in a single file that gets included by the
architecture specific files for the existing syscalls.

Assuming we do this, would that work for generating the metadata
from the same file like we do with
arch/x86/entry/syscalls/syscall{tbl,hdr}.sh ?

	Arnd
