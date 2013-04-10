Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Apr 2013 17:47:11 +0200 (CEST)
Received: from mail-ob0-f169.google.com ([209.85.214.169]:47819 "EHLO
        mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835044Ab3DJPrIAtXSi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Apr 2013 17:47:08 +0200
Received: by mail-ob0-f169.google.com with SMTP id wp18so556705obc.14
        for <linux-mips@linux-mips.org>; Wed, 10 Apr 2013 08:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=aw4nP/wW3oEg/d1w9UvVLAK0fVUY6eDbQvmyDCAExFY=;
        b=kMPOLGMo+P4LN3eGyOb9a9kSn9L0suUYwQtX5Fzym9TtcbULxl30GhP+D5uX5k9KEa
         sOyQzz/ObFwFEnuYiQSNCJso/ShKZv42dO0o9Orsto0ANvtsWNn6rskQJgy45WvAVhNR
         e0s3xPjBGc71h5KKUD0o2QdGQISs5O88HRNoOfRZ0QYVW3MhqmpzzKnqknEm2rLI7zcz
         NoajYtVvc9sHuHmosQ+p0h/2OWRun0h+G2osMJL7LLGIwQ2wwT50iiVzsihmS+ax7kfb
         fyM4oSJgKTt345jprlOne90jD+VOYOihIjPdOSWCIrpviCaKyyctz377hghZGggzuXib
         /IeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:x-gm-message-state;
        bh=aw4nP/wW3oEg/d1w9UvVLAK0fVUY6eDbQvmyDCAExFY=;
        b=Pg8bIVLP5e/h9n1F59wBtFBrt3rMud157JKSNPw7aFdqLQAb9cxAYx0yNNioldgn8p
         8xKRxg5VzbFuV5QQq79Q55x8xQNzOrpUvzooh5y/PiYsfWt3aCl++Vso+aQDcyfxUqgb
         k8Nkd7yPJR9oY3UheDYgxow69WWgK9RwQ75X9yNQWg5hnuEW6qVWoEbEe+5tltk7TiQW
         BMkuSTRuDqgRhAFfN6SXCRdiRkQB1C+8WP4hv6K/Mr12R5prrV5iDEFZM6ff5ZtfZKhS
         LSQ7W8lM3llGCGfLxRt/KMfFnu8oPtoI7ebtM92VicGCOXDVQYrBKws1ni9GhekeH7HJ
         I+5g==
X-Received: by 10.182.233.232 with SMTP id tz8mr913938obc.83.1365608820577;
 Wed, 10 Apr 2013 08:47:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.102.68 with HTTP; Wed, 10 Apr 2013 08:46:40 -0700 (PDT)
In-Reply-To: <1365098483-26821-1-git-send-email-juhosg@openwrt.org>
References: <1365098483-26821-1-git-send-email-juhosg@openwrt.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 10 Apr 2013 09:46:40 -0600
Message-ID: <CAErSpo5OrFCaax++wA+iUoHEDG=fwAJXRe=B6EEQS=EEQ5iKWw@mail.gmail.com>
Subject: Re: [PATCH 1/2] pci/of: remove weak annotation of pcibios_get_phb_of_node
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQkmjK5WfRqNDcwxKtzvt8Bf7DgTIwt8kQV+3mMUuey0f6FuqBrebYx7FYDNpCfyoErkwANftAbL3cS0t5QM1OuYyPc2tOacWe4fXrBbeL2jsFf1nnXCgATSz7TuSxABLNxNW+Ncz4wwzlYTVVjLoTgsuFoI72QY6ERN3iOsH4w6pZRURQHVObyFTklUM1QbeQFr2B6lvm1cKcNZLmxaNFw1cfqFbg==
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36065
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

On Thu, Apr 4, 2013 at 12:01 PM, Gabor Juhos <juhosg@openwrt.org> wrote:
> Due to the __weak annotation in the forward declaration
> of the 'pcibios_get_phb_of_node' function GCC will emit
> a weak symbol for this functions even if the actual
> implementation does not use the weak attribute.
>
> If an architecture tries to override the function
> by providing its own implementation there will be
> multiple weak symbols with the same name in the
> object files. When the kernel is linked from the
> object files the linking order determines which
> implementation will be used in the final image.
>
> On x86 and on powerpc the architecture specific
> version gets used:
>
>   $ readelf -s  arch/x86/kernel/built-in.o drivers/pci/built-in.o \
>     vmlinux.o | grep pcibios_get_phb_of_node
>     3338: 00029b80    86 FUNC    WEAK   DEFAULT    1 pcibios_get_phb_of_node
>     1701: 00012710    77 FUNC    WEAK   DEFAULT    1 pcibios_get_phb_of_node
>    52072: 0002a170    86 FUNC    WEAK   DEFAULT    1 pcibios_get_phb_of_node
>   $
>
>   $ powerpc-openwrt-linux-uclibc-readelf -s arch/powerpc/kernel/built-in.o \
>     drivers/pci/built-in.o vmlinux.o | grep pcibios_get_phb_of_node
>     1001: 0000cbb8    12 FUNC    WEAK   DEFAULT    1 pcibios_get_phb_of_node
>     1484: 0001471c    88 FUNC    WEAK   DEFAULT    1 pcibios_get_phb_of_node
>    28652: 0000d6f8    12 FUNC    WEAK   DEFAULT    1 pcibios_get_phb_of_node
>   $
>
> However on MIPS, the linker puts the default
> implementation into the final image:
>
>   $ mipsel-openwrt-linux-readelf -s arch/mips/pci/built-in.o \
>     drivers/pci/built-in.o vmlinux.o | grep pcibios_get_phb_of_node
>       86: 0000046c    12 FUNC    WEAK   DEFAULT    2 pcibios_get_phb_of_node
>     1430: 00012e2c   104 FUNC    WEAK   DEFAULT    2 pcibios_get_phb_of_node
>    31898: 0017e4ec   104 FUNC    WEAK   DEFAULT    2 pcibios_get_phb_of_node
>   $
>
> Rename the default implementation and remove the
> __weak annotation of that. This ensures that there
> will be no multiple weak symbols with the same name
> in the object files. In order to keep the expected
> behaviour, call the architecture specific function
> if the weak symbol is resolved.
>
> Also move the renamed function to the top instead
> of adding a new forward declaration for that.
>
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> ---
> Notes:
>
> Unfortunately I'm not a binutils/gcc expert, so
> I don't know if this is the expected behaviour
> of those or not.
>
> Removing the __weak annotation from the forward
> declaration of 'pcibios_get_phb_of_node' in
> 'include/linux/pci.h' also fixes the problem.
>
> The microblaze architecture also provides its own
> implementation. The behaviour of that is not tested
> but I assume that the linker chooses the arch specific
> implementation on that as well similarly to the
> x86/powerpc.
>
> The MIPS version is implemented in the followup
> patch.
>
> Removing the __weak annotation from the forward
> declaration of 'pcibios_get_phb_of_node' in
> 'include/linux/pci.h' also fixes the problem.

I think removing the __weak annotation from the declaration in
include/linux/pci.h is the correct solution.

__weak is an attribute of a function definition, not an attribute of
the interface, so I don't think it makes any sense to have it in
pci.h.

Bjorn

> -Gabor
> ---
>  drivers/pci/of.c |   41 +++++++++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index f092993..5794840 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -15,10 +15,32 @@
>  #include <linux/of_pci.h>
>  #include "pci.h"
>
> +static struct device_node *__pcibios_get_phb_of_node(struct pci_bus *bus)
> +{
> +       /* This should only be called for PHBs */
> +       if (WARN_ON(bus->self || bus->parent))
> +               return NULL;
> +
> +       if (pcibios_get_phb_of_node)
> +               return pcibios_get_phb_of_node(bus);
> +
> +       /* Look for a node pointer in either the intermediary device we
> +        * create above the root bus or it's own parent. Normally only
> +        * the later is populated.
> +        */
> +       if (bus->bridge->of_node)
> +               return of_node_get(bus->bridge->of_node);
> +       if (bus->bridge->parent && bus->bridge->parent->of_node)
> +               return of_node_get(bus->bridge->parent->of_node);
> +
> +       return NULL;
> +}
> +
>  void pci_set_of_node(struct pci_dev *dev)
>  {
>         if (!dev->bus->dev.of_node)
>                 return;
> +
>         dev->dev.of_node = of_pci_find_child_device(dev->bus->dev.of_node,
>                                                     dev->devfn);
>  }
> @@ -32,7 +54,7 @@ void pci_release_of_node(struct pci_dev *dev)
>  void pci_set_bus_of_node(struct pci_bus *bus)
>  {
>         if (bus->self == NULL)
> -               bus->dev.of_node = pcibios_get_phb_of_node(bus);
> +               bus->dev.of_node = __pcibios_get_phb_of_node(bus);
>         else
>                 bus->dev.of_node = of_node_get(bus->self->dev.of_node);
>  }
> @@ -42,20 +64,3 @@ void pci_release_bus_of_node(struct pci_bus *bus)
>         of_node_put(bus->dev.of_node);
>         bus->dev.of_node = NULL;
>  }
> -
> -struct device_node * __weak pcibios_get_phb_of_node(struct pci_bus *bus)
> -{
> -       /* This should only be called for PHBs */
> -       if (WARN_ON(bus->self || bus->parent))
> -               return NULL;
> -
> -       /* Look for a node pointer in either the intermediary device we
> -        * create above the root bus or it's own parent. Normally only
> -        * the later is populated.
> -        */
> -       if (bus->bridge->of_node)
> -               return of_node_get(bus->bridge->of_node);
> -       if (bus->bridge->parent && bus->bridge->parent->of_node)
> -               return of_node_get(bus->bridge->parent->of_node);
> -       return NULL;
> -}
> --
> 1.7.10
>
