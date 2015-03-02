Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Mar 2015 14:15:09 +0100 (CET)
Received: from mail-qa0-f52.google.com ([209.85.216.52]:64494 "EHLO
        mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006759AbbCBNPHsi33o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Mar 2015 14:15:07 +0100
Received: by mail-qa0-f52.google.com with SMTP id v10so22515751qac.11
        for <linux-mips@linux-mips.org>; Mon, 02 Mar 2015 05:15:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=KQyzdxyNTnV00HtLmqOFkcp/wGftQNdpVSl0VK5LegM=;
        b=abO//vOqEMKf93aemevppOhu8vy5hCl/UDM7SRIe9GFv5GJdk5p+v73q3Zk+d9ArCX
         3dz7kHHIceCyr3xgvs3BMQc3sjwfChluGsYBvGYXooMssP70qR7x4c8jOmnlLo+r798q
         vDbXO2IcG11fUYQjWA6fnzFmT8OGa7k8nR9fqZU2NdditiipKuVCVqZXGdk9/6mZ5kbQ
         04ak7vrJh0bU+iMhi+rVVBlnDTBSudklgIcM3qhhuJvfWSUQuawKB4C2qkS9qhLzir+R
         Y5oAIXZtSbdbXfIhFfNCNwqXOl3JzgIJoLtlzEF6U2ZIXx6K4uOkkRDL2c7A4D3Iiubs
         3f0A==
X-Gm-Message-State: ALoCoQnN9BwSyTboxopa41QGTXPEN77hX39bdYPoHZW0h+FPUcxKVVcTofVBGY++yqnU1DS3UX00
X-Received: by 10.140.150.131 with SMTP id 125mr52836506qhw.55.1425302102490;
        Mon, 02 Mar 2015 05:15:02 -0800 (PST)
Received: from [192.168.1.139] (h96-61-87-245.cntcnh.dsl.dynamic.tds.net. [96.61.87.245])
        by mx.google.com with ESMTPSA id f9sm8323142qgf.17.2015.03.02.05.15.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2015 05:15:01 -0800 (PST)
Message-ID: <54F4624D.6000909@hurleysoftware.com>
Date:   Mon, 02 Mar 2015 08:14:53 -0500
From:   Peter Hurley <peter@hurleysoftware.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>, robh@kernel.org,
        grant.likely@linaro.org
CC:     gregkh@linuxfoundation.org, jslaby@suse.cz, arnd@arndb.de,
        f.fainelli@gmail.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH V3 3/7] of: Document {little,big,native}-endian bindings
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com> <1416872182-6440-4-git-send-email-cernekee@gmail.com>
In-Reply-To: <1416872182-6440-4-git-send-email-cernekee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <peter@hurleysoftware.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peter@hurleysoftware.com
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

On 11/24/2014 06:36 PM, Kevin Cernekee wrote:
> These apply to newly converted drivers, like serial8250/libahci/...
> The examples were adapted from the regmap bindings document.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  .../devicetree/bindings/common-properties.txt      | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/common-properties.txt
> 
> diff --git a/Documentation/devicetree/bindings/common-properties.txt b/Documentation/devicetree/bindings/common-properties.txt
> new file mode 100644
> index 0000000..21044a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/common-properties.txt
> @@ -0,0 +1,60 @@
> +Common properties
> +
> +The ePAPR specification does not define any properties related to hardware
> +byteswapping, but endianness issues show up frequently in porting Linux to
> +different machine types.  This document attempts to provide a consistent
> +way of handling byteswapping across drivers.
> +
> +Optional properties:
> + - big-endian: Boolean; force big endian register accesses
> +   unconditionally (e.g. ioread32be/iowrite32be).  Use this if you
> +   know the peripheral always needs to be accessed in BE mode.
> + - little-endian: Boolean; force little endian register accesses
> +   unconditionally (e.g. readl/writel).  Use this if you know the
> +   peripheral always needs to be accessed in LE mode.  This is the
> +   default.

There is a fundamental problem with specifying the default in DT bindings.
How can drivers which are currently native-endian support big-endian?

If the driver is converted to support big-endian, every previous
devicetree will be invalid with the new kernel (because those devicetrees
don't specify 'native-endian').

IOW, consider if the default were 'native-endian'. How would the 8250
driver support existing devicetrees?

Regards,
Peter Hurley


> + - native-endian: Boolean; always use register accesses matched to the
> +   endianness of the kernel binary (e.g. LE vmlinux -> readl/writel,
> +   BE vmlinux -> ioread32be/iowrite32be).  In this case no byteswaps
> +   will ever be performed.  Use this if the hardware "self-adjusts"
> +   register endianness based on the CPU's configured endianness.
> +
> +Note that regmap, in contrast, defaults to native-endian.  But this
> +document is targeted for existing drivers, most of which currently use
> +readl/writel because they expect to be accessing PCI/PCIe devices rather
> +than memory-mapped SoC peripherals.  Since the readl/writel accessors
> +perform a byteswap on BE systems, this means that the drivers in question
> +are implicitly "little-endian".
> +
> +Examples:
> +Scenario 1 : CPU in LE mode & device in LE mode.
> +dev: dev@40031000 {
> +	      compatible = "name";
> +	      reg = <0x40031000 0x1000>;
> +	      ...
> +	      native-endian;
> +};
> +
> +Scenario 2 : CPU in LE mode & device in BE mode.
> +dev: dev@40031000 {
> +	      compatible = "name";
> +	      reg = <0x40031000 0x1000>;
> +	      ...
> +	      big-endian;
> +};
> +
> +Scenario 3 : CPU in BE mode & device in BE mode.
> +dev: dev@40031000 {
> +	      compatible = "name";
> +	      reg = <0x40031000 0x1000>;
> +	      ...
> +	      native-endian;
> +};
> +
> +Scenario 4 : CPU in BE mode & device in LE mode.
> +dev: dev@40031000 {
> +	      compatible = "name";
> +	      reg = <0x40031000 0x1000>;
> +	      ...
> +	      little-endian;
> +};
> 
