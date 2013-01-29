Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jan 2013 19:35:20 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:36942 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833269Ab3A2SfSZV9cZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Jan 2013 19:35:18 +0100
Message-ID: <510815CB.7030100@phrozen.org>
Date:   Tue, 29 Jan 2013 19:32:43 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120922 Icedove/10.0.7
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: add irqdomain support for the CPU IRQ controller
References: <1359410344-19737-1-git-send-email-blogic@openwrt.org> <5106F7DC.1040307@openwrt.org> <51080992.6030905@gmail.com>
In-Reply-To: <51080992.6030905@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>


> Is it necessary to use the word 'intc'? What does that mean? Perhaps
> "mti,cpu-interrupt-controller"?
>

the name is only a detail and if you prefer said name i have no prolem 
with that.


>> Please use this as an actual device tree documentation binding.
>
> Yes, bindings should be documented in
> Documentation/devicetree/bindings/mips

Sure i will repost in a bit with a binding document

> Just to satisfy my curiosity, Which drivers are using (or will be using)
> these mapping facilities? The timer and performance counters already
> work, so it isn't needed for them. What will use this.

we updated the ralink series i posted a few days ago to make use of this 
patch.

the SoC has its own irq controller behind STATUSF_IP2.

STATUSF_IP5 is wired to ethernet and STATUSF_IP6 is wired to wifi

i think on some socs from ralink the pci is wired to STATUSF_IP3

to be able to nicely represent this in a devicetree we need an entry for 
the mips cpu interrupt controller.

as the patch no exists I am considering to update the lantiq code to 
make use of it. Also the patch originates from gabors ath79 devicetree 
series, which also makes use of it.

	John
