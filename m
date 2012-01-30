Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jan 2012 17:49:56 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:55635 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903700Ab2A3Qtu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Jan 2012 17:49:50 +0100
Received: by bke5 with SMTP id 5so4929434bke.36
        for <multiple recipients>; Mon, 30 Jan 2012 08:49:44 -0800 (PST)
Received: by 10.204.10.80 with SMTP id o16mr6021463bko.50.1327942184418;
        Mon, 30 Jan 2012 08:49:44 -0800 (PST)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id ci12sm38728634bkb.13.2012.01.30.08.49.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 08:49:42 -0800 (PST)
Message-ID: <4F26D815.3040105@mvista.com>
Date:   Mon, 30 Jan 2012 20:49:09 +0300
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
Subject: Re: [PATCH 2/3] mips: use the the PCI controller's io_map_base
References: <cover.1327877053.git.mst@redhat.com> <dd3dab360f11d4f8829854891d04bf838bc50e5e.1327877053.git.mst@redhat.com>
In-Reply-To: <dd3dab360f11d4f8829854891d04bf838bc50e5e.1327877053.git.mst@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 01/30/2012 03:18 PM, Michael S. Tsirkin wrote:

> commit eab90291d35438bcebf7c3dc85be66d0f24e3002

    Please add that commit's summary in parens.

> failed to take into account the PCI controller's
> io_map_base for mapping IO BARs.
> This also caused a new warning on mips.

> Fix this, without re-introducing code duplication,
> by setting NO_GENERIC_PCI_IOPORT_MAP
> and supplying a mips-specific __pci_ioport_map.

> Reported-by: Kevin Cernekee <cernekee@gmail.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

WBR, Sergei
