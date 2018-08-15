Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Aug 2018 02:46:51 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:41266 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993890AbeHOAqsaPYLV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Aug 2018 02:46:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=2Hr8AYr0XGdxPYYgq4FuvNQxydLrTMaIbuSQUrAJjFY=;
        b=4nJ7R/yrgHwnojxl3BNUnIXNC5vkZtNcMbBfvKkmEVd90TQMH2ci303Ny2XRElCAhXEnZUCSig2UqoMMyUmx5tM3jU4bcNynursEwRpDXUFwEeWEnU0F+PgrKhf5JIdlanEf2s+0Ovcy1MeV9jxMNNjh+WLnX3oIV/CwmsegfQw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fpjxM-0003JX-ED; Wed, 15 Aug 2018 02:46:36 +0200
Date:   Wed, 15 Aug 2018 02:46:36 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Rob Herring <robh@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        linux-usb@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        Xue Liu <liuxuenetmail@gmail.com>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        devicetree@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        Alexander Graf <agraf@suse.de>,
        "LoRa_Community_Support@semtech.com" 
        <LoRa_Community_Support@semtech.com>,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Stefan Rehm <rehm@miromico.ch>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: serdev: How to attach serdev devices to USB based tty devices?
Message-ID: <20180815004636.GB11610@lunn.ch>
References: <3639955d-5990-1c82-7158-ac07b33c41f2@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3639955d-5990-1c82-7158-ac07b33c41f2@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrew@lunn.ch
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

Hi Andreas

This not my area of expertise. But i wanted to point out that there
exists a mechanism to make the FDTI driver release a port so that it
can be used from user space, e.g. for JTAG. It might be possible to
extend this mechanism to make the FTDI driver perform the registration
to serdev.

It is however not a generic solution.

   Andrew
