Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Nov 2013 06:16:31 +0100 (CET)
Received: from mail-ee0-f53.google.com ([74.125.83.53]:32900 "EHLO
        mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816285Ab3KAFQYqWhI0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Nov 2013 06:16:24 +0100
Received: by mail-ee0-f53.google.com with SMTP id e51so1785816eek.40
        for <multiple recipients>; Thu, 31 Oct 2013 22:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-type:content-disposition
         :in-reply-to;
        bh=9H1fXFdsBi3jVS5m+KfSlM4PcS99kgBWwnG3kpYlSYs=;
        b=rDS2AaObUp/Q6T8k6M2yzICETEyzlMxWWjeRdiLM1DAvy22JmRRFIJSlXxox8mWze/
         Q85AY35SkbHHl4aqk62+jrzKMA3WQUHeIPG0+gAmzHQ/K2hb0/iZMIgnSrGN9X2HH9h3
         6ouz2yXNrF8mWSwuyz0XJ54t3Er2Gsa9FhnUp2AuxGBdq00imsmnWLBNJKbtRlG3lWa8
         a6J6n7x1v4TzsUqJZiWAMyNi99SuAVaDzXbDRjC7+OkxyHsrJyFDoj9ZsrSseJ7v/E6i
         LTeVnTrfPrbBXPMSl/93tmrOXUmQwCITyF+YUR/cVSyfrmzpwaiA87+hqEMhl4QWV9vO
         Ydlg==
X-Received: by 10.14.175.199 with SMTP id z47mr241082eel.130.1383282979377;
        Thu, 31 Oct 2013 22:16:19 -0700 (PDT)
Received: from glitch (j115181.upc-j.chello.nl. [24.132.115.181])
        by mx.google.com with ESMTPSA id m54sm3068718eex.2.2013.10.31.22.16.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 22:16:18 -0700 (PDT)
Received: by glitch (Postfix, from userid 1000)
        id A68F23C01F5; Fri,  1 Nov 2013 06:16:10 +0100 (CET)
Date:   Fri, 1 Nov 2013 06:16:10 +0100
From:   Domenico Andreoli <cavokz@gmail.com>
To:     Stephen Warren <swarren@wwwdotorg.org>
Cc:     Domenico Andreoli <domenico.andreoli@linux.com>,
        linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/11] RFC: Common machine reset handling
Message-ID: <20131101051610.GA28233@glitch>
Mail-Followup-To: Stephen Warren <swarren@wwwdotorg.org>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org
References: <20131031062708.520968323@linux.com>
 <5272D05E.1070207@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5272D05E.1070207@wwwdotorg.org>
Return-Path: <cavokz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cavokz@gmail.com
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

On Thu, Oct 31, 2013 at 03:49:18PM -0600, Stephen Warren wrote:
> On 10/31/2013 12:27 AM, Domenico Andreoli wrote:
> > Hi,
> > 
> >   I've been looking for a solution to my bcm4760 watchdog based restart
> > hook when I noticed that the kernel reboot/shutdown mechanism is having
> > a few unaddressed issues.
> > 
> > Those I identified are:
> > 
> >  1) context pointer often needed by the reset hook
> >     (currently local static data is used for this pourpose)
> >  2) unclear ownership/policy in case of multiple reset hooks
> >     (currently almost nobody seems to care much)
> 
> I'm not sure how this patchset solves (2); even with the new API, it's
> still the case that whichever code calls set_machine_reset() last wins,
> just like before where whichever code wrote to pm_power_off won. I'm not
> sure what this series attempts to solve.

That's right, the last wins. But the previous has a chance to know.

I only supposed there is somebody in charge of selecting the best handler
for the machine. Don't know how fancy this decision is but at least for
the vexpress there is also a sysfs way to configure different reset methods
from user-space.

So cleaning up things after the handler is replaced seemed a sensible
thing to do.

Another "problem" this patch would solve is the registration of the
reset handler in a architecture independent way. Now an otherwise platform
generic gpio HW reset driver would need to do different things on different
architectures.

thanks,
Domenico
