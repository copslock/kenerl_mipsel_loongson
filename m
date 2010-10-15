Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Oct 2010 02:17:36 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19804 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491107Ab0JOARd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Oct 2010 02:17:33 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cb79dbc0000>; Thu, 14 Oct 2010 17:18:04 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 14 Oct 2010 17:17:44 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 14 Oct 2010 17:17:44 -0700
Message-ID: <4CB79D93.6090500@caviumnetworks.com>
Date:   Thu, 14 Oct 2010 17:17:23 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Grant Likely <grant.likely@secretlab.ca>,
        devicetree-discuss@lists.ozlabs.org
CC:     linux-mips <linux-mips@linux-mips.org>,
        Prasun Kapoor <prasun.kapoor@caviumnetworks.com>
Subject: Device Tree questions WRT MIPS/Octeon SOCs.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Oct 2010 00:17:44.0422 (UTC) FILETIME=[636E2860:01CB6BFE]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Grant,

I have been following your MIPS device tree patches and have begun to 
experiment with them.  If you could give some feedback on my ideas, I 
would appreciate it.

Background:

The Octeon is a MIPS64 based SOC family.  The various members of the 
Octeon family have several Ethernet ports of different types, one or 
more MDIO and I2C busses and other miscellaneous devices.  People put 
the SOCs on boards that have a wide variety of PHYs, I2C devices all 
connected in different ways.

Currently we have ad hoc code throughout the drivers and platform 
initialization code that specify how everything is connected.

Plan:

I want to convert this to use the device tree and related functions.

Since none of the existing hardware has an existing device tree I plan 
on taking a two pronged approach.

Modify platform drivers to get configuration information from the device 
tree.  Then:

1) Load and use a dtb blob as specified on the kernel command line.

2) If no command line dtb specified, use a default dtb embedded in the 
kernel image and then edit or patch it using of_attach_node(), 
of_detach_node(), prom_remove_property(), and prom_add_property() based 
on some of the the same ad hoc code we currently use.

Q: As a very high level plan does this make any sense?

Would you recommend something else?

Thanks in advance,
David Daney
