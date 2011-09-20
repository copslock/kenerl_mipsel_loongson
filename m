Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2011 02:40:13 +0200 (CEST)
Received: from lo.gmane.org ([80.91.229.12]:44709 "EHLO lo.gmane.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491826Ab1ITAkI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Sep 2011 02:40:08 +0200
Received: from list by lo.gmane.org with local (Exim 4.69)
        (envelope-from <sgi-linux-mips@m.gmane.org>)
        id 1R5oNb-0005TW-BG
        for linux-mips@linux-mips.org; Tue, 20 Sep 2011 02:40:07 +0200
Received: from customer-GDL-177-153.megared.net.mx ([customer-GDL-177-153.megared.net.mx])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Tue, 20 Sep 2011 02:40:07 +0200
Received: from bsdero by customer-GDL-177-153.megared.net.mx with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Tue, 20 Sep 2011 02:40:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mips@linux-mips.org
From:   BSDero <bsdero@gmail.com>
Subject: Does the VIA VT6212 USB Host controller works on SGI/Mips?
Date:   Tue, 20 Sep 2011 00:22:14 +0000 (UTC)
Message-ID: <loom.20110920T021938-457@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 189.192.177.153 (Mozilla/5.0 (Windows; U; Windows NT 5.1; es-ES; rv:1.9.1.19) Gecko/20110420 Firefox/3.5.19 FBSMTWB)
X-archive-position: 31108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bsdero@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10263

I'm working on a Driver for this device in Irix, and I don't know if this works
ok... I can not get PCI interrupts with this device... 

How is it in SGI/MIps Linux? 
