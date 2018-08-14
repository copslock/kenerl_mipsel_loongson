Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2018 09:31:38 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:56758 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992492AbeHNHbe5KcjI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Aug 2018 09:31:34 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2641EAEE6;
        Tue, 14 Aug 2018 07:31:29 +0000 (UTC)
Message-ID: <1534231386.31827.3.camel@suse.com>
Subject: Re: serdev: How to attach serdev devices to USB based tty devices?
From:   Oliver Neukum <oneukum@suse.com>
To:     Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Rob Herring <robh@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        linux-usb@vger.kernel.org
Cc:     Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Xue Liu <liuxuenetmail@gmail.com>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Stefan Rehm <rehm@miromico.ch>,
        "LoRa_Community_Support@semtech.com" 
        <LoRa_Community_Support@semtech.com>,
        Alexander Graf <agraf@suse.de>, devicetree@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Date:   Tue, 14 Aug 2018 09:23:06 +0200
In-Reply-To: <3639955d-5990-1c82-7158-ac07b33c41f2@suse.de>
References: <3639955d-5990-1c82-7158-ac07b33c41f2@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <oneukum@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oneukum@suse.com
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

On Di, 2018-08-14 at 04:28 +0200, Andreas Färber  wrote:
> My idea then was that if we had some unique criteria like vendor and
> product IDs (or whatever is supported in usb_device_id), we could write
> a usb_driver with suitable USB_DEVICE*() macro. In its probe function we
> could call into the existing tty driver's probe function and afterwards
> try creating and attaching the appropriate serdev device, i.e. a fixed
> USB-to-serdev driver mapping. Problem is that most devices don't seem to
> implement any unique identifier I could make this depend on - either by
> using a standard FT232/FT2232/CH340G chip or by using STMicroelectronics
> virtual com port identifiers in CDC firmware and only differing in the
> textual description [3] the usb_device_id does not seem to match on.

If you really must do this you can benignly fail probe(). Thus you
can compare strings within your probe() method.
This sucks because you need to make sure your drivers are always
loaded in a certain order and you really rely on undocumented
properties, but it can be done.

	Regards
		Oliver
