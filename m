Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Feb 2010 21:55:41 +0100 (CET)
Received: from g4t0017.houston.hp.com ([15.201.24.20]:17515 "EHLO
        g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491838Ab0BVUzh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Feb 2010 21:55:37 +0100
Received: from g4t0018.houston.hp.com (g4t0018.houston.hp.com [16.234.32.27])
        by g4t0017.houston.hp.com (Postfix) with ESMTP id 07B08381CC;
        Mon, 22 Feb 2010 20:55:31 +0000 (UTC)
Received: from ldl (ldl.fc.hp.com [15.11.146.30])
        by g4t0018.houston.hp.com (Postfix) with ESMTP id F1081100B1;
        Mon, 22 Feb 2010 20:55:29 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
        by ldl (Postfix) with ESMTP id DA5BDCF004A;
        Mon, 22 Feb 2010 13:55:29 -0700 (MST)
Received: from ldl ([127.0.0.1])
        by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a3CuSBrjna+O; Mon, 22 Feb 2010 13:55:29 -0700 (MST)
Received: from tigger.helgaas (lart.fc.hp.com [15.11.146.31])
        by ldl (Postfix) with ESMTP id C3820CF0040;
        Mon, 22 Feb 2010 13:55:29 -0700 (MST)
From:   Bjorn Helgaas <bjorn.helgaas@hp.com>
To:     Yoichi Yuasa <yuasa@linux-mips.org>
Subject: Re: Reverting old hack
Date:   Mon, 22 Feb 2010 13:55:28 -0700
User-Agent: KMail/1.9.10
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <20100220113134.GA27194@linux-mips.org> <1266677869.1320.8.camel@dc7800.home> <20100221164531.382b3785.yuasa@linux-mips.org>
In-Reply-To: <20100221164531.382b3785.yuasa@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201002221355.28939.bjorn.helgaas@hp.com>
Return-Path: <bjorn.helgaas@hp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bjorn.helgaas@hp.com
Precedence: bulk
X-list: linux-mips

On Sunday 21 February 2010 12:45:31 am Yoichi Yuasa wrote:
> > I'd like to understand the PCI architecture of Cobalt better.  Would you
> > mind turning on CONFIG_PCI_DEBUG and posting the dmesg log?
> 
> If you want to know what happen, you can see my old e-mail. 
> 
> http://marc.info/?l=linux-kernel&m=118792430424186&w=2

There's not much detail there.  It would save me a lot of time if
you could collect the complete dmesg log, /proc/iomem, and /proc/ioports.

Thanks,
  Bjorn
