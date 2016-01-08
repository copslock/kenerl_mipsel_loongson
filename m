Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jan 2016 11:12:59 +0100 (CET)
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33699 "EHLO
        mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008374AbcAHKM5v6jJC convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 8 Jan 2016 11:12:57 +0100
Received: by mail-lb0-f169.google.com with SMTP id sv6so214509086lbb.0;
        Fri, 08 Jan 2016 02:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MjQhP6UBIuWW3K2GHEf4sQw0se0Bl6MCsj2HzRJ/S1Y=;
        b=h0hLwQadC6vHiFpKDB4Thgj9YB5grBU4TV1y0UnM35rJMODEV+JON37vgiVjtq2Swp
         QWqx18vHAwQBpdDOyqMA7BqC+83VPzRdqgvJfTRx6tmCLwxwqRIdvKClQ0tmZZzFAMhq
         ykiyYm+RQyFUTKlrXP+HKqwdoxGiG49g9mcLGgSRHf+9qJt0NVk/SMvwm7XaUYH0J3LG
         JT6DB71Is442//agUPCfB+ycb9OuuhQhYvK5FDvhlQfe8C+fh8muA2z6hGPCiTQuRt/+
         eD1pmRAzQsQhR6IKaFpAHZQXVU5qtO6ycYAGaNnEpDV+kcTOkXJoXAR8N+9DcORI9XJN
         31sA==
X-Received: by 10.112.52.38 with SMTP id q6mr7587155lbo.112.1452247972178;
        Fri, 08 Jan 2016 02:12:52 -0800 (PST)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id l204sm1737711lfg.49.2016.01.08.02.12.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Jan 2016 02:12:51 -0800 (PST)
Date:   Fri, 8 Jan 2016 13:37:39 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Joshua Henderson <joshua.henderson@microchip.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 05/14] dt/bindings: Add bindings for PIC32/MZDA
 platforms
Message-Id: <20160108133739.9a9c63c18fee346098354b21@gmail.com>
In-Reply-To: <1452211389-31025-6-git-send-email-joshua.henderson@microchip.com>
References: <1452211389-31025-1-git-send-email-joshua.henderson@microchip.com>
        <1452211389-31025-6-git-send-email-joshua.henderson@microchip.com>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

On Thu, 7 Jan 2016 17:00:20 -0700
Joshua Henderson <joshua.henderson@microchip.com> wrote:

> This adds support for the Microchip PIC32 platform along with the
> specific variant PIC32MZDA on a PIC32MZDA Starter Kit.
> 
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/mips/pic32/microchip,pic32mzda.txt    |   33 ++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/pic32/microchip,pic32mzda.txt
> 
> diff --git a/Documentation/devicetree/bindings/mips/pic32/microchip,pic32mzda.txt b/Documentation/devicetree/bindings/mips/pic32/microchip,pic32mzda.txt
> new file mode 100644
> index 0000000..bcf3e04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/pic32/microchip,pic32mzda.txt
> @@ -0,0 +1,33 @@
> +* Microchip PIC32MZDA Platforms
> +
> +PIC32MZDA Starter Kit
> +Required root node properties:
> +    - compatible = "microchip,pic32mzda-sk", "microchip,pic32mzda"
> +
> +CPU nodes:
> +----------
> +A "cpus" node is required.  Required properties:
> + - #address-cells: Must be 1.
> + - #size-cells: Must be 0.
> +A CPU sub-node is also required.  Required properties:
> + - device_type: Must be "cpu".
> + - compatible: Must be "mti,mips14KEc".
> +Example:
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "mti,mips14KEc";
> +		};
> +	};
> +
> +Boot protocol
> +--------------
> +In accordance with the MIPS UHI specification[1], the bootloader must pass the
> +following arguments to the kernel:
> + - $a0: -2.
> + - $a1: KSEG0 address of the flattened device-tree blob.
> +
> +[1] http://prplfoundation.org/wiki/MIPS_documentation

At the moment the link [1] does not work. It is redirected to nonexisting "http://wiki.prplfoundation.org//MIPS_documentation" (prplfoundation.org site problem?).

The http://wiki.prplfoundation.org/wiki/MIPS_documentation URL works.

The "MIPS documentation" wiki page contains many documents so can we use 
more accurate URL, e.g. http://wiki.prplfoundation.org/wiki/MIPS_documentation#Unified_Hosting_Interface ?

Can we use more strict name for "MIPS UHI specification", e.g. "Unified Hosting Interface Reference Manual (MD01069)"?

-- 
Best regards,
  Antony Pavlov
