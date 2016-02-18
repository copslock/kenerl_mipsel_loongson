Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Feb 2016 22:45:57 +0100 (CET)
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35894 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013038AbcBRVpzq-Hl7 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Feb 2016 22:45:55 +0100
Received: by mail-lf0-f53.google.com with SMTP id 78so41735877lfy.3
        for <linux-mips@linux-mips.org>; Thu, 18 Feb 2016 13:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=A1/fBbBX0PihkeHtgpW62XmhVddNra9xl0BwoTm4i5o=;
        b=a2gzBvvzN7qSb0zZICuj56e5knp1EKEDwWmCXvn1Ioi8E4fvVugurAaGiJlIpehhx8
         5I2QpKtAo9bVaOeSO1Kcbq+iWlkpk26MvpOa++BG3+yd9+CEYkkd02ebeB2a9szVpbO6
         /GYiuTMcvZsaJLduQToeBaQ15Ja1YEZuuRL222YzbZPR38wxu1CCl7ExYDl97izi/Fco
         0uoblCFoUzMN4jyk0taN+9JprrSmC+jqUehzk0XYPn/MWHIlhoDnfv/ehTNNV2c6sOr5
         l0TNNLwyqibb8OsFkmAiT/zIh+R5mevR2DPf/OI5by6sDV2KUfoCyx4ZaonwAuZVh7U1
         Gp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=A1/fBbBX0PihkeHtgpW62XmhVddNra9xl0BwoTm4i5o=;
        b=WzKaUmAMcA87NvjHbZ+fTv+YeLBJoskQXVl3hEpoeaDwe3giHZIigSZ4baf8pCy8bx
         8oBsn+adR3/T2lhnXJpKkRx0XAXiR3FXFL/Pqd1fnXHD2CrNEAq3g7T1Y4FSWzXamrOe
         /eyEjun8aXo/9OV2p8Zy1G2pBNRAa0bA4NeLTIszoc98rCojq/MTkuFvjTn4RH+n80vH
         MnD6+/Y/Cu8v9+mD7rlh7uFtYVw26jHdrZ0VBr19ZO2TBaPJMLvxPvi38UXgUaAYUP6w
         sYTF0t4v60hfPR53/pzZBQEi8kasaEM+qEdrriJDpap9cpyjdOUFqxzMoVDCpwjjNjdg
         9row==
X-Gm-Message-State: AG10YOQcvwFgAkiyZvxowEOI7Cib+1dndmLj12mR4raKWg636SkHvLwgUTTCI3/3lUTJ+Q==
X-Received: by 10.25.17.103 with SMTP id g100mr4176428lfi.142.1455831950346;
        Thu, 18 Feb 2016 13:45:50 -0800 (PST)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id fb9sm1159316lbc.26.2016.02.18.13.45.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Feb 2016 13:45:49 -0800 (PST)
Date:   Fri, 19 Feb 2016 01:11:37 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Marek Vasut <marex@denx.de>, linux-mips@linux-mips.org,
        Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v5 07/15] usb: ehci: add vbus-gpio parameter
Message-Id: <20160219011137.d8f85d72bbaa18c6e206dd09@gmail.com>
In-Reply-To: <56C60DF8.1060809@cogentembedded.com>
References: <1455005641-7079-8-git-send-email-antonynpavlov@gmail.com>
        <Pine.LNX.4.44L0.1602181111350.1280-100000@iolanthe.rowland.org>
        <20160218210652.68ae464eed8ddbffd33e7a02@gmail.com>
        <56C60DF8.1060809@cogentembedded.com>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52122
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

On Thu, 18 Feb 2016 21:31:20 +0300
Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> wrote:

> On 02/18/2016 09:06 PM, Antony Pavlov wrote:
[...]
> > so I use regulator in the TL-MR3020 board dts file:
> >
> >          reg_usb_vbus: reg_usb_vbus {
> >                  compatible = "regulator-fixed";
> >                  regulator-name = "usb_vbus";
> >                  regulator-min-microvolt = <5000000>;
> 
>     Not 0?
> 
> >                  regulator-max-microvolt = <5000000>;
> >                  gpio = <&gpio 8 GPIO_ACTIVE_HIGH>;
> 
>     Where's the switch if both voltages are equal?

Here is a quote from linux/Documentation/devicetree/bindings/regulator/fixed-regulator.txt

        Any property defined as part of the core regulator
        binding, defined in regulator.txt, can also be used.
        However a fixed voltage regulator is expected to have the
        regulator-min-microvolt and regulator-max-microvolt
        to be the same.

Moreover please see this of_get_fixed_voltage_config() code fragment
(please see linux/drivers/regulator/fixed.c for details):

	if (init_data->constraints.min_uV == init_data->constraints.max_uV) {
		config->microvolts = init_data->constraints.min_uV;
	} else {
		dev_err(dev,
			 "Fixed regulator specified with variable voltages\n");
		return ERR_PTR(-EINVAL);
	}

-- 
Best regards,
  Antony Pavlov
