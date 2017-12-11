Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Dec 2017 14:17:14 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23990425AbdLKNRFkwIv8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Dec 2017 14:17:05 +0100
Date:   Mon, 11 Dec 2017 13:17:05 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Joe Perches <joe@perches.com>
cc:     SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-mips@linux-mips.org,
        =?UTF-8?Q?Ralf_B=C3=A4chle?= <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] TC: Delete an error message for a failed memory allocation
 in tc_bus_add_devices()
In-Reply-To: <1512957931.26342.31.camel@perches.com>
Message-ID: <alpine.LFD.2.21.1712110244450.4266@eddie.linux-mips.org>
References: <bfb63956-346c-aa17-5b06-fbe19ff0a5e3@users.sourceforge.net>         <alpine.LFD.2.21.1712102140570.4266@eddie.linux-mips.org> <1512957931.26342.31.camel@perches.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61414
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

On Sun, 10 Dec 2017, Joe Perches wrote:

> > > Omit an extra message for a memory allocation failure in this function.
> > > 
> > > This issue was detected by using the Coccinelle software.
> > 
> >  And the problem here is?
> 
> Markus' terrible commit messages.
> 
> Generically, any OOM via a malloc like call has a dump_stack()
> which shows a stack trace unless __GFP_NOWARN is used.
> 
> So this message is generally unnecessary as the dump_stack()
> will show the tc_bus_add_devices function name and (now hashed)
> value of the function address.

 Fair enough.

> What will be different is the particular slot # of the tc_dev
> will no longer be shown.
> 
> Really though, if there's an OOM on the init, there are larger
> problems and the system will be unusable.

 Well, the problem may well be the caller doing something silly, so we do 
want to have it identified, hence the extra message.  Given that, as you 
say, `kzalloc' already provides the necessary diagnostic I agree the 
message can go.

 However I would indeed prefer that a commit description is at least 
exhaustive enough for such a dumb reviewer as I am to understand what is 
going on right away.  So please make it say at least:

"Remove an extraneous message that duplicates the diagnostic already 
provided by `kzalloc' for a memory allocation failure in this function."

or suchlike in v2 for me to apply a Reviewed-by: tag.

 Thanks,

  Maciej
