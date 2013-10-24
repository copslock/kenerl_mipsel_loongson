Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Oct 2013 18:38:05 +0200 (CEST)
Received: from mail-wg0-f47.google.com ([74.125.82.47]:62965 "EHLO
        mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817664Ab3JXQh7Gu3TN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Oct 2013 18:37:59 +0200
Received: by mail-wg0-f47.google.com with SMTP id c11so2633953wgh.14
        for <linux-mips@linux-mips.org>; Thu, 24 Oct 2013 09:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:subject:to:cc:in-reply-to:references
         :date:message-id;
        bh=nKbswNhPRVZZNd10fCMY6rUZxyhOyL64p0/78JDf9cw=;
        b=KR/gbeGLwz7fRazevJkP6ZGBZce+BrkVvSWofQOqZMUqtshLrnnIAKHjAPSUSJbT+s
         dKHV52gGOgMrvw6At2ir4pelAefHsgKTiFXB/W5VNqF36rcSql+yWtsV6ZBRoU9bE4lO
         JFbYeAnghllXAtAojtFOE8iXauOWFuSrd6wo1AbRUJcS8xODlbtafBF/1wxt4zA2HMxe
         bXES/iVAqBNDqy0XqpoAyCYYKnLOq5x/BDjjHnicPf8aviHjyDS7v3KcxI2m9C+2fRLc
         UppxiS6Cd7pNaqPM308gMGOLxIIU+QeCvBrrmXjfkoLmvgOj0FyAy1LIWGMC+5iMYLrN
         Yg0w==
X-Gm-Message-State: ALoCoQm7qwF5PCdwkH23J0ipFJfhxv879n0rZoxDdqkZdSideUf0bjge0uDmWduNujv1uszCEERQ
X-Received: by 10.180.208.2 with SMTP id ma2mr3021960wic.52.1382632673633;
        Thu, 24 Oct 2013 09:37:53 -0700 (PDT)
Received: from trevor.secretlab.ca (ip-77-221-165-98.dsl.twang.net. [77.221.165.98])
        by mx.google.com with ESMTPSA id e5sm28564937wiy.2.2013.10.24.09.37.51
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 24 Oct 2013 09:37:52 -0700 (PDT)
Received: by trevor.secretlab.ca (Postfix, from userid 1000)
        id 68D01C403B6; Thu, 24 Oct 2013 17:37:49 +0100 (BST)
From:   Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v2 08/10] of/platform: Resolve interrupt references at probe time
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <rob.herring@calxeda.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@arm.linux.org.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20131015232436.19F61C40099@trevor.secretlab.ca>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com> <1379510692-32435-9-git-send-email-treding@nvidia.com> <20131015232436.19F61C40099@trevor.secretlab.ca>
Date:   Thu, 24 Oct 2013 17:37:49 +0100
Message-Id: <20131024163749.68D01C403B6@trevor.secretlab.ca>
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@linaro.org
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

On Wed, 16 Oct 2013 00:24:36 +0100, Grant Likely <grant.likely@linaro.org> wrote:
> On Wed, 18 Sep 2013 15:24:50 +0200, Thierry Reding <thierry.reding@gmail.com> wrote:
> > Interrupt references are currently resolved very early (when a device is
> > created). This has the disadvantage that it will fail in cases where the
> > interrupt parent hasn't been probed and no IRQ domain for it has been
> > registered yet. To work around that various drivers use explicit
> > initcall ordering to force interrupt parents to be probed before devices
> > that need them are created. That's error prone and doesn't always work.
> > If a platform device uses an interrupt line connected to a different
> > platform device (such as a GPIO controller), both will be created in the
> > same batch, and the GPIO controller won't have been probed by its driver
> > when the depending platform device is created. Interrupt resolution will
> > fail in that case.
> 
> What is the reason for all the rework on the irq parsing return values?
> A return value of '0' is always an error on irq parsing, regardless of
> architecture even if NO_IRQ is defined as -1. I may have missed it, but
> I don't see any checking for specific error values in the return paths
> of the functions.
> 
> If the specific return value isn't required (and I don't think it is),
> then you can simplify the whole series by getting rid of the rework
> patches.

I've not heard back about the above, but I've just had a conversation
with Rob about what to do here. The problem that I have is that it makes
a specific return code need to traverse several levels of function calls
and have a meaning come out the other end. It becomes difficult to
figure out where that code actually comes from when reading the code.
That's more of a gut-feel reaction rather than pointing out specifics
though.

The other thing that makes me nervous how invasive the series is.

However, even with saying all of the above, I'm not saying outright no.
I want to get this feature in. It is obviously needed and I'll even
merge the patches piecemeal as the look ready (I've already merged 2).
Regardless, the current series needs to be reworked. It conflicts with
the other IRQ rework that I've already put into my tree. The best thing
to do would probably be respin it against my current tree and repost.
I'll take a fresh look then.... In the mean time, anything you can do to
/sanely/ reduce the impact will probably help.  :-)

g.
