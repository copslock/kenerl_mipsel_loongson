Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jan 2012 17:51:29 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:50816 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903702Ab2A3QvY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Jan 2012 17:51:24 +0100
Received: by bke5 with SMTP id 5so4931558bke.36
        for <multiple recipients>; Mon, 30 Jan 2012 08:51:19 -0800 (PST)
Received: by 10.204.153.199 with SMTP id l7mr9214159bkw.88.1327942278965;
        Mon, 30 Jan 2012 08:51:18 -0800 (PST)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id ez5sm38722436bkc.15.2012.01.30.08.51.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 08:51:18 -0800 (PST)
Message-ID: <4F26D875.7050403@mvista.com>
Date:   Mon, 30 Jan 2012 20:50:45 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:6.0) Gecko/20110812 Thunderbird/6.0
MIME-Version: 1.0
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Kevin Cernekee <cernekee@gmail.com>,
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
Subject: Re: [PATCH 3/3] sh: use the the PCI channels's io_map_base
References: <cover.1327877053.git.mst@redhat.com> <60def7835613710ecae4878ae5742c45b05791df.1327877053.git.mst@redhat.com>
In-Reply-To: <60def7835613710ecae4878ae5742c45b05791df.1327877053.git.mst@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 01/30/2012 03:19 PM, Michael S. Tsirkin wrote:

> commit 43db595e8b5d78ce5ad2feab719814a76e3ad2e5

    Please add that commit's summary in parens.

> failed to take into account the PCI channels's
> io_map_base for mapping IO BARs.
> This also caused a new warning on sh.

> Fix this, without re-introducing code duplication,
> by setting NO_GENERIC_PCI_IOPORT_MAP
> and supplying a sh-specific __pci_ioport_map.

> Reported-by: Kevin Cernekee<cernekee@gmail.com>
> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>

WBR, Sergei
