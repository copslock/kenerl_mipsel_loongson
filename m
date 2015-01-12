Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jan 2015 13:08:31 +0100 (CET)
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:33322 "EHLO
        pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010456AbbALMIaXtEM2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Jan 2015 13:08:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Ys0xNJzvnomJ16r5rbT5d4IDKUMXYW/i4Vos3Sg/WGc=;
        b=FPai8cGYYo5BFzccI2QSpU2Cv9aB1uHpsdnmJJO1aFFCAeRJQqcQVyvewiYTV9PzVyq8hBS4xl/ygDa71TxQNs8OkcNLVM0IkGXozgtLl5EfFdF745MQ0nV5yzYzeDKwoorb65dc3zJepNwL6iK4bGGETm8eRoznFNaXnQBuHT8=;
Received: from n2100.arm.linux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:57040)
        by pandora.arm.linux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1YAdn8-0007ft-VF; Mon, 12 Jan 2015 12:08:19 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1YAdn5-0002XR-1a; Mon, 12 Jan 2015 12:08:15 +0000
Date:   Mon, 12 Jan 2015 12:08:14 +0000
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 02/11] i2c: add quirk checks to core
Message-ID: <20150112120814.GE12302@n2100.arm.linux.org.uk>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
 <1420824103-24169-3-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1420824103-24169-3-git-send-email-wsa@the-dreams.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
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

On Fri, Jan 09, 2015 at 06:21:32PM +0100, Wolfram Sang wrote:
> +static int i2c_quirk_error(struct i2c_adapter *adap, struct i2c_msg *msg, char *err_msg)
> +{
> +	dev_err(&adap->dev, "quirk: %s (addr 0x%04x, size %u)\n", err_msg, msg->addr, msg->len);
> +	return -EOPNOTSUPP;
> +}

So, what happens if I open an I2C adapter, find a message which causes
i2c_quirk_error() to be called, and then spin repeatedly calling that...
Shouldn't there be some rate limiting to this?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
