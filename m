Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jan 2012 16:52:25 +0100 (CET)
Received: from moutng.kundenserver.de ([212.227.17.8]:53606 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903693Ab2A3PwV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Jan 2012 16:52:21 +0100
Received: from klappe2.localnet (deibp9eh1--blueice3n2.emea.ibm.com [195.212.29.180])
        by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
        id 0M5V4W-1SpCCk2a1Q-00xctF; Mon, 30 Jan 2012 16:51:51 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/3] lib: add NO_GENERIC_PCI_IOPORT_MAP
Date:   Mon, 30 Jan 2012 15:51:46 +0000
User-Agent: KMail/1.12.2 (Linux/3.3.0-rc1; KDE/4.3.2; x86_64; ; )
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
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
References: <cover.1327877053.git.mst@redhat.com> <d78d91d0166651700cf662a50c87d84da4bdab88.1327877053.git.mst@redhat.com>
In-Reply-To: <d78d91d0166651700cf662a50c87d84da4bdab88.1327877053.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201201301551.46907.arnd@arndb.de>
X-Provags-ID: V02:K0:cJ6K0n3+KbPZf09E6BUK0YrxBfCnYSoBrcL2kOnh9ta
 Z2P8/Z+X+GU6rR/g+/zM7CghI7mfTqJ7BU91kWvD/nKk/OWiGt
 MQk16FklkEyy2egrM0kal8kGhTf2l5wT1XklJJU7McXda5PJCf
 gbQ0dHXaJKrWSTx2V4LHMDKWcD2or2aCU9BzGo1KTUzw7TC4iN
 JHMgF3K13CTMsi7QcC+C7+qNx48L0RG1vPGeSATdC09TV2YSnz
 ZddW6qFv00oHjwZBiFX7UsZQJKvcyW6YqXQwpgItPUUdWd/vj8
 ickYhzDOo3wEKax5WKEC94umngbigX3YgvOv3yEzs5eeJBcj42
 ofglebNMSiL5kKKPW7y8=
X-archive-position: 32328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Monday 30 January 2012, Michael S. Tsirkin wrote:
> --- a/include/asm-generic/pci_iomap.h
> +++ b/include/asm-generic/pci_iomap.h
> @@ -15,6 +15,11 @@ struct pci_dev;
>  #ifdef CONFIG_PCI
>  /* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
>  extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
> +/* Create a virtual mapping cookie for a port on a given PCI device.
> + * Do not call this directly, it exists to make it easier for architectures
> + * to override. */
> +extern void __iomem *__pci_ioport_map(struct pci_dev *dev, unsigned long port,
> +                                     unsigned int nr);
>  #else
>  static inline void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max)
>  {
> index 4b0fdc2..1dfda29 100644
> --- a/lib/pci_iomap.c
> +++ b/lib/pci_iomap.c
> @@ -9,6 +9,16 @@
>  #include <linux/export.h>
>  
>  #ifdef CONFIG_PCI
> +#ifndef CONFIG_NO_GENERIC_PCI_IOPORT_MAP
> +/* Architectures can override ioport mapping while
> + * still using the rest of the generic infrastructure. */
> +void __iomem *__pci_ioport_map(struct pci_dev *dev,
> +                              unsigned long port,
> +                              unsigned int nr)
> +{
> +       return ioport_map(port, nr);
> +}
> +#endif
>  /**
>   * pci_iomap - create a virtual mapping cookie for a PCI BAR
>   * @dev: PCI device that owns the BAR

This looks correct, but it would be nicer to express this with an inline
function and keeping the new #ifdef to the header file, like

+/*
+ * Create a virtual mapping cookie for a port on a given PCI device.
+ * Do not call this directly, it exists to make it easier for architectures
+ * to override.
+ */
+#ifdef CONFIG_NO_GENERIC_PCI_IOPORT_MAP
+extern void __iomem *__pci_ioport_map(struct pci_dev *dev, unsigned long port,
+                                     unsigned int nr);
+#else
+static inline void __iomem *__pci_ioport_map(struct pci_dev *dev,
+                              unsigned long port, unsigned int nr)
+{
+       return ioport_map(port, nr);
+}
+#endif

	Arnd
