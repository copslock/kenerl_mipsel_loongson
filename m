Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2011 09:23:22 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:44451 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491023Ab1F3HXR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Jun 2011 09:23:17 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id D52C38BD3;
        Thu, 30 Jun 2011 09:23:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cYxj66KRg26w; Thu, 30 Jun 2011 09:23:12 +0200 (CEST)
Received: from [192.168.0.152] (host-091-097-251-103.ewe-ip-backbone.de [91.97.251.103])
        by hauke-m.de (Postfix) with ESMTPSA id 14A908BCA;
        Thu, 30 Jun 2011 09:23:12 +0200 (CEST)
Message-ID: <4E0C245F.5040107@hauke-m.de>
Date:   Thu, 30 Jun 2011 09:23:11 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110516 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        mb@bu3sch.de, george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com,
        arnd@arndb.de, julian.calaby@gmail.com, sshtylyov@mvista.com
Subject: Re: [RFC v3 03/13] bcma: add functions to scan cores needed on SoCs
References: <1309385518-12097-1-git-send-email-hauke@hauke-m.de>        <1309385518-12097-4-git-send-email-hauke@hauke-m.de> <BANLkTimAE-xphUYeMMzzz6B531tedo6Vkw@mail.gmail.com>
In-Reply-To: <BANLkTimAE-xphUYeMMzzz6B531tedo6Vkw@mail.gmail.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 30558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 24647

On 06/30/2011 08:42 AM, Rafał Miłecki wrote:
> 2011/6/30 Hauke Mehrtens <hauke@hauke-m.de>:
-		err = bcma_get_next_core(bus, &eromptr, core);
-		if (err == -ENXIO)
+		err = bcma_get_next_core(bus, &eromptr, NULL, core_num, core);
+		if (err == -ENODEV) {
+			core_num++;
+			continue;
+		} else if (err == -ENXIO)
 			continue;
 		else if (err == -ESPIPE)
 			break;
 		else if (err < 0)
 			return err;

+		core->core_index = core_num++;
+		bus->nr_cores++;
+
 		pr_info("Core %d found: %s "
 			"(manuf 0x%03X, id 0x%03X, rev 0x%02X, class 0x%X)\n",
-			bus->nr_cores, bcma_device_name(&core->id),
+			core->core_index, bcma_device_name(&core->id),
 			core->id.manuf, core->id.id, core->id.rev,
 			core->id.class);

-		core->core_index = bus->nr_cores++;
> 
> Didn't you just change core indexes (0, 1, ...) to numbers (1, 2,
> ...)? It would break enabling IRQs on PCI.
No, the cores are getting the same indexes numbers as before. While
scanning core_num is increased for every core found also for cores we
are not searching for or we already found. Then core_num will be
assigned to core->core_index. bus->nr_cores is no used any more so it
could be removed or is it needed for something else?

As you can see here [0] it finds core 0 and 3 at first and then the others.
> 
> Didn't test it however yet, I'll have access to my machines tomorrow.
> 

Hauke

[0] http://permalink.gmane.org/gmane.linux.kernel.wireless.general/71851
