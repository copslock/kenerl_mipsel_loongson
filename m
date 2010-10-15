Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Oct 2010 02:32:34 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:61474 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491107Ab0JOAca convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Oct 2010 02:32:30 +0200
Received: by gwj18 with SMTP id 18so126580gwj.36
        for <linux-mips@linux-mips.org>; Thu, 14 Oct 2010 17:32:22 -0700 (PDT)
Received: by 10.150.55.27 with SMTP id d27mr396312yba.284.1287102741167; Thu,
 14 Oct 2010 17:32:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.150.49.9 with HTTP; Thu, 14 Oct 2010 17:32:00 -0700 (PDT)
In-Reply-To: <4CB79D93.6090500@caviumnetworks.com>
References: <4CB79D93.6090500@caviumnetworks.com>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Thu, 14 Oct 2010 18:32:00 -0600
X-Google-Sender-Auth: V3UhQrrc27NsxqXVmqYQLDcDl24
Message-ID: <AANLkTi=UM2p26JJMqv-cNh8xACS_KPf_dCst5cgmh5VR@mail.gmail.com>
Subject: Re: Device Tree questions WRT MIPS/Octeon SOCs.
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     devicetree-discuss@lists.ozlabs.org,
        linux-mips <linux-mips@linux-mips.org>,
        Prasun Kapoor <prasun.kapoor@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

Hi David.

On Thu, Oct 14, 2010 at 6:17 PM, David Daney <ddaney@caviumnetworks.com> wrote:
[...]
> I want to convert this to use the device tree and related functions.
>
> Since none of the existing hardware has an existing device tree I plan on
> taking a two pronged approach.
>
> Modify platform drivers to get configuration information from the device
> tree.  Then:
>
> 1) Load and use a dtb blob as specified on the kernel command line.
>
> 2) If no command line dtb specified, use a default dtb embedded in the
> kernel image and then edit or patch it using of_attach_node(),
> of_detach_node(), prom_remove_property(), and prom_add_property() based on
> some of the the same ad hoc code we currently use.
>
> Q: As a very high level plan does this make any sense?

Overall the plan makes sense, however I would suggest the following.
instead of 'live' modifying the tree, another option is to carry a set
of 'stock' device trees in the kernel; one per board.  Of course this
assumes that your current ad-hoc code is keying on the specific board.
 If it is interpreting data provided by the firmware, then your
suggestion of modifying a single stock tree probably makes more sense,
or possibly a combination of the too.  In general you should avoid
live modification as much as possible.

g.
