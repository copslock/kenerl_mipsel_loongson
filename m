Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Mar 2018 00:14:09 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:56344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990401AbeCIXODCWxfs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 10 Mar 2018 00:14:03 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FF2E208FE;
        Fri,  9 Mar 2018 23:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF2E208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Fri, 9 Mar 2018 23:13:51 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mmc@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 11/14] MIPS: dts: jz4780: Add DMA controller node to the
 devicetree
Message-ID: <20180309231351.GJ24558@saruman>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
 <20180309151219.18723-12-ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UlxN1C6awaFNesUv"
Content-Disposition: inline
In-Reply-To: <20180309151219.18723-12-ezequiel@vanguardiasur.com.ar>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--UlxN1C6awaFNesUv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Mar 09, 2018 at 12:12:16PM -0300, Ezequiel Garcia wrote:
> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
...
> +	dma: dma@13420000 {
> +		compatible = "ingenic,jz4780-dma";
> +		reg = <0x13420000 0x10000>;
> +		#dma-cells = <2>;
> +
> +		interrupt-parent = <&intc>;
> +		interrupts = <10>;
> +
> +		clocks = <&cgu JZ4780_CLK_PDMA>;
> +
> +		status = "disabled";
> +	};

Is there any point in disabling the DMAC by default? I thought that was
mainly used for peripheral devices which might not be brought out of the
SoC on all boards.

Cheers
James

--UlxN1C6awaFNesUv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqjFS8ACgkQbAtpk944
dnotyQ/7BoPfxHsGzOsWoNwWcJmFpYBlzawFVJojyjCEjlUNClON5emEJva+/3Nn
h7lKVdvC8P86TqX2Qm5/E74Xq+foLSJ5OruB/6fz68vSldWtuVF0Xuz+nENDDoU1
5JSWioNFdopbeXqGKaxBkV6QwWNpz6LGvsuXJRgFjhwCmU8uTOB1VCyfb/Qty7dC
E0NOvP6hM75qsiTR6lzOgplKVSebX9pnp5HtCc0nHOAlK8KoYrfqp7vMyB0IWyBY
SoccPpoPhdB8QcCsUdMb0jj41KkMNxaOeD4yvpj/bbMZv8Q6asLu2wPl99N9Olcw
cGSXrReCzL89GlPkWifCbxjKlUK/TO7rhPxCfQYY+20vS22iR/62yng42Xa4LVaD
KEF8rXKFRssKCz4iXE6TFnbD7iBmcefeMbNZQCv8gNCgqEG5mBnQ6eeMLk440MJc
DSdQyFl+4ijVgqm35vSYmXzmwGPXhlsSMpQ7UT5yOyY9dgOVPgGzT+9U5hykokMy
mWzEMxMXak5pig9DyfEnDioOcO8ismcE/WYcYj4rP2Qa7lHsId+R562+zCQccb5Y
QKxboQnyJDBRhf9ju6JaI3xYPQZ7VWrlujztK95Phl4LwrSzrrhhjZg8KRtjJWCa
lgWcVzBb3k3johaK2T9cuOXwD6zhkvbb4Jxl3wBWIiI4Q9OmE7I=
=cYNG
-----END PGP SIGNATURE-----

--UlxN1C6awaFNesUv--
