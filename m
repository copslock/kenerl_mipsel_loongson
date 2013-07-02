Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jul 2013 19:16:41 +0200 (CEST)
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64443 "EHLO
        mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835080Ab3GBRPNYtjAy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jul 2013 19:15:13 +0200
Received: by mail-ob0-f174.google.com with SMTP id wd20so5839953obb.19
        for <linux-mips@linux-mips.org>; Tue, 02 Jul 2013 10:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xF+DXO4KSbCkA4lU7sHkBVhSf2mVUPKtorHqZnZNSCg=;
        b=aX4REXTaYidDZyLoDI0LFita4FddxeIYey/UtGGZWqRcFQuMQvfow6fsCU6JkTWHRf
         Kpaa4O/SFWfLCitOSp42zB1KO2bvfmq7dwUuGHRbh8VBRplI80w3OG6J0K8Om4lpw+z9
         frG/lbH2CSOwJ7p2Vtl541O6if2IyqObH5lU8AxDwdaMDkIC2wFKFJDtR9+FCoPTCBUK
         IHWGeHBayOP3fGtF82fUPj/oxno3Jeu7dWLAIlEiVYgME5yKpLmKeqDtwhhE+uUD1lyN
         XqhJFgClP0GaBLYeZj/InEetvV8UVrRRQqKN4QB5fVzFmyZOHmWjB7O1h8sS5e5uBB23
         M13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=xF+DXO4KSbCkA4lU7sHkBVhSf2mVUPKtorHqZnZNSCg=;
        b=YtxhY/ol1oYApRFAhA5ICTTj7eKGosu+rCPoGxKGnKiDuVjScRj/HxYpq8284ZuUdI
         fS7KJLIT/JiYo1lTcCQK3PIa+wgfCN6rfGQ4GxTRDlT9qUIyQj0BXhUH4CxM8W/UuoTH
         zEVMFsbycweEvgFkBaeOV0gTlB7707hR+U1dNyB5dOkP0rShH+8zzLC0y4tKKBm66wb+
         RopaYgsmoG2Q8YILLQgTz68RBT62nCobbZ+em5S+4Dht3GUV8vFqPmmXIhMlLVz3/e/u
         9Iu04nDAxEM5BXF9YOPSvL6UAahMGVFWBDG+wsyo26cEzUs7bS7tdZEYGI+FoFcMO8Ld
         dmbw==
X-Received: by 10.182.81.202 with SMTP id c10mr13742446oby.27.1372785261566;
 Tue, 02 Jul 2013 10:14:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.75.99 with HTTP; Tue, 2 Jul 2013 10:14:01 -0700 (PDT)
In-Reply-To: <20130702073037.55a53642@skate>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372726396.17904.1.camel@concordia> <20130702073037.55a53642@skate>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 2 Jul 2013 11:14:01 -0600
Message-ID: <CAErSpo5NuwC5cWiWxOb0c3tO47SPBcbW3Vx5vMu=cCu2m4vYLw@mail.gmail.com>
Subject: Re: [PATCHv4 02/11] pci: use weak functions for MSI arch-specific functions
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Michael Ellerman <michael@ellerman.id.au>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Lior Amsalem <alior@marvell.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        linux-s390@vger.kernel.org, "x86@kernel.org" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Chris Metcalf <cmetcalf@tilera.com>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maen Suleiman <maen@marvell.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux390@de.ibm.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQnfwxGXIooLQAFj9ojZL367+2aoCnSsa/GjvHub0y9dUBr73NNCGR9OhMrFQaiXqQDaInBOcfIxqAkJaa/R1Rj5cRJIKbUh5EwzHyEg6oEZNsnIHvVOyVFr3WoCG7vIu9SNZ2dk4aDxAMqZ+9IgRbpCf3TjK9pOUsxpzM45JOVxEe2GuzHJNByVXJ60neAh/cifaUD4Vf7umAqAd9P9avSl8MFiNA==
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

On Mon, Jul 1, 2013 at 11:30 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Michael Ellerman,
>
> On Tue, 02 Jul 2013 10:53:16 +1000, Michael Ellerman wrote:
>> On Mon, 2013-07-01 at 15:42 +0200, Thomas Petazzoni wrote:
>> > Until now, the MSI architecture-specific functions could be overloaded
>> > using a fairly complex set of #define and compile-time
>> > conditionals. In order to prepare for the introduction of the msi_chip
>> > infrastructure, it is desirable to switch all those functions to use
>> > the 'weak' mechanism. This commit converts all the architectures that
>> > were overidding those MSI functions to use the new strategy.
>>
>> The MSI code used to use weak functions, until we discovered they were
>> being miscompiled on some toolchains (11df1f0). I assume these days
>> we're confident they work correctly.
>
> Hum, interesting. I see from your commit that gcc 4.3.2 was apparently
> affected, and gcc 4.3.x is not /that/ old. Bjorn, what's your point of
> view on this?

There *were* compilation issues with weak functions, but AFAIK they've
been resolved and there's no reason to avoid them.  Commit f9d142500
addressed this.

Bjorn
