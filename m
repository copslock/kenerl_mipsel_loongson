Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jun 2015 16:55:06 +0200 (CEST)
Received: from mail-la0-f49.google.com ([209.85.215.49]:32770 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008806AbbFVOzElHjyK convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Jun 2015 16:55:04 +0200
Received: by laka10 with SMTP id a10so111597572lak.0;
        Mon, 22 Jun 2015 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=EMNsDFfBmO5qB7XdoMkCxklk2LJ6o6XphTLn8ipTMTo=;
        b=AO5WtBT2XNtAtC3L08XlLUM9N7USJR63IS9cQKFAPDKy5Po3/nRCrBBG/0JV0ndTqy
         iShtL3dw54awy426dbktiAmCz1t9WoKG8/FBUXaHcTh4KSnyiaL17XdapbNaAwIbwBNB
         QMNARyWvSez+gZKZcrIkTKvjsS1bsmHAcrk8XXzrfv24buhhm6ES/SY9Fce8E3RctLVb
         bIgCxJRZYDcIH48x/ZJhNvGXbM6BvD75s0QvEI9SS8+urSBdn+/v2BPlGpPqbOQhcnI9
         YIiugrbg0iC6aBnQRbvTZWTlS8Yo/HOQGmEJdKOlP8KoSNYtqsSCNw4SoKPJNLTndxg/
         ndcg==
X-Received: by 10.112.154.71 with SMTP id vm7mr29843411lbb.96.1434984899241;
        Mon, 22 Jun 2015 07:54:59 -0700 (PDT)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by mx.google.com with ESMTPSA id ew6sm4755548lbc.40.2015.06.22.07.54.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2015 07:54:58 -0700 (PDT)
Date:   Mon, 22 Jun 2015 18:01:23 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Alban <albeu@free.fr>
Cc:     linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/12] MIPS: Add basic support for the TL-WR1043ND
 version 1
Message-Id: <20150622180123.f171a1985eb3c984465144f8@gmail.com>
In-Reply-To: <20150620125137.2020a855@tock>
References: <1433029955-7346-1-git-send-email-albeu@free.fr>
        <1433031506-7984-5-git-send-email-albeu@free.fr>
        <20150608131758.9d76be074998ea3de0e976a4@gmail.com>
        <20150610235811.0b18af9b@tock>
        <20150615104213.92258d2d0616c12e4aa7bf1a@gmail.com>
        <20150620125137.2020a855@tock>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48003
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

On Sat, 20 Jun 2015 12:51:37 +0200
Alban <albeu@free.fr> wrote:

> On Mon, 15 Jun 2015 10:42:13 +0300
> Antony Pavlov <antonynpavlov@gmail.com> wrote:
> 
> > On Wed, 10 Jun 2015 23:58:11 +0200
> > Alban <albeu@free.fr> wrote:
> > 
> > > On Mon, 8 Jun 2015 13:17:58 +0300
> > > Antony Pavlov <antonynpavlov@gmail.com> wrote:
> > > 
> > > > IMHO AR9132 SoC can't work without external oscilator.
> > > > 
> > > > Can we just move basic extosc declaration to SoC dt file
> > > > (ar9132.dtsi)? So board dt file ar9132_tl_wr1043nd_v1.dts will
> > > > contain only oscilator clock frequency value.
> > > 
> > > I would prefer to keep the split between the files in sync with the
> > > hardware. I understand that most simple board designs use a fixed
> > > oscillator, but that might not always be the case.
> > > 
> > 
> > The AR9132 SoC __always__ use one external oscilator.
> 
> Yes, but what I don't like is to impose the clock source being a
> fixed-oscillator. What if the board use a clock from another
> component that need to be represented in the DT as something else
> than a fixed-oscillator?

The absolute majority of the ar9132-based boards has fixed-oscillator
(Actually I suppose all of them has fixed oscillator).

If some board has different clock source then we can completely alter
extosc node in the board dts file. (But I have some doubts in existence
of such board.)

-- 
Best regards,
  Antony Pavlov
