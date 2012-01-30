Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jan 2012 15:19:42 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:57024 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903688Ab2A3OTi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Jan 2012 15:19:38 +0100
Received: by iafj26 with SMTP id j26so6481266iaf.36
        for <multiple recipients>; Mon, 30 Jan 2012 06:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=glOgYlptzA46iGk28AjtcKAojoMSeqrZIp1Tgre1SME=;
        b=t07NKW6fciECKqtzJo5AvqQZFqqO4zDdFjB1uDbaIe00fOOuqwFJTvYGbAYFg/0BIU
         JgyrL+aC+MIJ7xrGFMfgVACLVt/gQOuIzXEqj44OY+m1Hh84o1fv4joGpRSDp2tB24qK
         9fjGb5EIKoncDZ4iC3xP2vilKCjqhFZehF/6Y=
MIME-Version: 1.0
Received: by 10.42.168.6 with SMTP id u6mr11369008icy.9.1327933171756; Mon, 30
 Jan 2012 06:19:31 -0800 (PST)
Received: by 10.231.54.4 with HTTP; Mon, 30 Jan 2012 06:19:31 -0800 (PST)
In-Reply-To: <d78d91d0166651700cf662a50c87d84da4bdab88.1327877053.git.mst@redhat.com>
References: <cover.1327877053.git.mst@redhat.com>
        <d78d91d0166651700cf662a50c87d84da4bdab88.1327877053.git.mst@redhat.com>
Date:   Mon, 30 Jan 2012 08:19:31 -0600
Message-ID: <CACoURw6docF1E4KwvfAAwh3GG0KFo15erj+JJwu0HHB-wtswig@mail.gmail.com>
Subject: Re: [PATCH 1/3] lib: add NO_GENERIC_PCI_IOPORT_MAP
From:   Shane McDonald <mcdonald.shane@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Myron Stowe <myron.stowe@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Dmitry Kasatkin <dmitry.kasatkin@intel.com>,
        James Morris <jmorris@namei.org>,
        "John W. Linville" <linville@tuxdriver.com>,
        Michael Witten <mfwitten@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 32326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Just a minor nit on the comment:

On Mon, Jan 30, 2012 at 6:18 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> Some architectures need to override the way
> IO port mapping is does not PCI devices.

Should this line read "IO port mapping is done on PCI devices."?

> Supply a generic function that calls
> ioport_map, and make it possible for architectures
> to override.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Shane
