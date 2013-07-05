Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jul 2013 23:34:52 +0200 (CEST)
Received: from mail-ob0-f179.google.com ([209.85.214.179]:55907 "EHLO
        mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831921Ab3GEVeg5FL4- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jul 2013 23:34:36 +0200
Received: by mail-ob0-f179.google.com with SMTP id xk17so3320449obc.24
        for <linux-mips@linux-mips.org>; Fri, 05 Jul 2013 14:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=z8ktEPWiS70Fe9fzHy32EAbCfrdP9R5wn7O1PbImyJA=;
        b=nX/u5jdTp5FF3R65A4s6veFDnlhzLwLk9sVdzabJ7E3rtFKGjTUsqBEyFZsnf+WkiB
         AXfDxq4pPAlCu2fdVFTr/psbU0SiFF6X0V+hvGBX4WwNs0yWJiJh4kd4zDtv0x1+Oci0
         C6MXvGOSqrUBO64hfFoCSeARomHWOZKaATebd8y7KXazry3c0AMDqjV2sAJSReMe1sxT
         TpSOcvDMSo6wC/7tqzWi+5B0koG//3Cy9IJtRDuus6jS73rixVuE2Jpyuv0xWp6nT51f
         kZgzz75muSV8a+CvZ6GYOTO3ESKk6P9EWFcSGGAdHBTDGUkUApjS8xfCevGR1eQhSP8J
         QWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=z8ktEPWiS70Fe9fzHy32EAbCfrdP9R5wn7O1PbImyJA=;
        b=loa+4s7YjTySEZ+8ri0891GHxY2e2xdnw85J1TQptF/VToNNTdnbaQJwH1ZTb+0Gbz
         PX+uOFEe0lBzw3+eC7kmarjhQHOcUaqXUvn1VaX5Nuc7faFr+VN5bZDUHbdetPy6xYqV
         lFnmVDBKlHGsP4Ag+83nC8y2HU3QZWlM+9YXAhjC9pMQHoxUnWa2UwTiOsfC4PJy2/+n
         zbtDPgcHi1KUVZKKFnhwXZ8EN9Vzg0pIbqFffbpN98qXyXDxTiE2t6teuWmZLYiuyKjO
         W0tz5I5d8QuPp1vUvNtMoWsWtGR3q0S8kJDSdSMIHiKJkSTH6GfLF+7bRZ5PSLIKdYC3
         xakQ==
X-Received: by 10.182.186.66 with SMTP id fi2mr13053453obc.98.1373060070614;
 Fri, 05 Jul 2013 14:34:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.75.99 with HTTP; Fri, 5 Jul 2013 14:34:10 -0700 (PDT)
In-Reply-To: <CAErSpo5uCpQftDmsMYEsFMtt_LP3kZPQ3Y4zz4VT7GdpcFq+1w@mail.gmail.com>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-3-git-send-email-thomas.petazzoni@free-electrons.com> <CAErSpo5uCpQftDmsMYEsFMtt_LP3kZPQ3Y4zz4VT7GdpcFq+1w@mail.gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 5 Jul 2013 15:34:10 -0600
Message-ID: <CAErSpo4HoofGhN8VumRnN0sN_+gWJ9gVQJVMiePnDBUKwh74ag@mail.gmail.com>
Subject: Re: [PATCHv4 02/11] pci: use weak functions for MSI arch-specific functions
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Maen Suleiman <maen@marvell.com>,
        Lior Amsalem <alior@marvell.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, linux-s390@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQnYSi5iSRNDygkfjwrv8fq9sc1mivkCQ+h0Fo95qknCcAJJx2CCfUFgja/PVbhREUzSSlsDVT4eDTYevXjDR7uPfjQzP7B5EPAztkoUx6UJa0CvROZ/1a7cDnOiKxVRomAGeMjrCdEZU6r8sZ8KeQpzl7eJ/SLh+og08iiha972BVIgsndrM+frN/iUPLl4aD8Yd4qumRDcQcPbBw6t3jonUFoEGQ==
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37271
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

On Fri, Jul 5, 2013 at 3:32 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:

> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

But please update your subject line to use consistent capitalization, e.g.,

PCI: Use weak ...
