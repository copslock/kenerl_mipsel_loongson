Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 04:03:03 +0100 (CET)
Received: from mail-lf0-f46.google.com ([209.85.215.46]:33243 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27024807AbcCQDDCYeMo4 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Mar 2016 04:03:02 +0100
Received: by mail-lf0-f46.google.com with SMTP id h198so32797744lfh.0;
        Wed, 16 Mar 2016 20:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=oa6wHG+IcfCwzHiW9qEuVXSv3UzeblRDWAb4Hacz0Zs=;
        b=pLefl859q6jWXehGuJKggRkVZZBQiNe444Lc5rWXV17tvfnGMPxpjl6g+mvOB/HhfC
         MRClzc8ask90J12zJcS1vknmlnLAifJ8mgxWU4zHmEqlEq4+oQHgSfN/pX7qJL2BQV42
         u7D0JlRmzg+Yk/cgDZipYi1zeDWL3FuTev51Px7n/XIpLmcEYrOR5iKJTAlqSBbH9S1Y
         Nm1+I4bylI8YXyRVx+DczM+8CBaO7KJGVE8lHnvX0VIvouBOnctsw3mm6lJ1NNi0nvX1
         se8dLZGDmrpiFmdfr77Hw9xBQ7h/TAblqVOgRj+h1RhfYz1QGUowurVUiM+spsPPA7dk
         AqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=oa6wHG+IcfCwzHiW9qEuVXSv3UzeblRDWAb4Hacz0Zs=;
        b=Mos5F70DvaOyjTf03+8knii9BXugvWVFz1J/PdX1kkZt3v7uJI1Ehzq1X4oQIY+GhI
         TFO3J8OqcFV7iCTGMYC44GTheCFffS2JXqqDkQ7hYxhopNsHduUznjiPgPO0GK/ClLUH
         eaoezuDrQ1Ga1ZbHjoFnLYXiYRFkJwb4yOxgJN5xsvDgzgYnrE3Vdw1B+FjTwBMywg1f
         qrYwT3gx/PWw4PCFkFO/8keGB4Tp0tX21NXOvOiQfkhegnKSdvBAIxGvXkp2DMJh13ZJ
         J1kxyfrF4aMno8q6DSGB5yZJ1Od5bOH+CsTFEQz8XSQhmbgjArXDGv16Nu8qclrVIzM9
         MBuA==
X-Gm-Message-State: AD7BkJIO7cGoqujbJQ1YPYVKRiMQAGBf1zOEgguaGxRDJAh6bCXjZ5GJtfd64My+bAMgdA==
X-Received: by 10.25.82.213 with SMTP id g204mr2708028lfb.142.1458183776968;
        Wed, 16 Mar 2016 20:02:56 -0700 (PDT)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id e6sm1012428lbk.32.2016.03.16.20.02.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Mar 2016 20:02:55 -0700 (PDT)
Date:   Thu, 17 Mar 2016 06:02:23 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     "Ralf Baechle" <ralf@linux-mips.org>,
        "Rob Herring" <robh@kernel.org>
Cc:     "Zubair Lutfullah Kakakhel" <Zubair.Kakakhel@imgtec.com>,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: WARNING: DT compatible string vendor "mips" appears un-documented
Message-Id: <20160317060223.e14ebbdf05224845279843c3@gmail.com>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52613
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

Hi all,

checkpatch.pl notes that DT compatible string vendor "mips" appears un-documented.

On the one hand there are several users of this vendor string:

    linux$ git grep \"mips,
    Documentation/devicetree/bindings/mips/img/xilfpga.txt: - compatible: Must be "mips,m14Kc".
    Documentation/devicetree/bindings/mips/img/xilfpga.txt:                 compatible = "mips,m14Kc";
    arch/mips/boot/dts/lantiq/danube.dtsi:                  compatible = "mips,mips24Kc";
    arch/mips/boot/dts/qca/ar9132.dtsi:                     compatible = "mips,mips24Kc";
    arch/mips/boot/dts/ralink/mt7620a.dtsi:                 compatible = "mips,mips24KEc";
    arch/mips/boot/dts/ralink/rt2880.dtsi:                  compatible = "mips,mips4KEc";
    arch/mips/boot/dts/ralink/rt3050.dtsi:                  compatible = "mips,mips24KEc";
    arch/mips/boot/dts/ralink/rt3883.dtsi:                  compatible = "mips,mips74Kc";
    arch/mips/boot/dts/xilfpga/microAptiv.dtsi:                     compatible = "mips,m14Kc";

On the other hand we already have the "mti" vendor string:

    linux$ grep MIPS Documentation/devicetree/bindings/vendor-prefixes.txt
    mti    Imagination Technologies Ltd. (formerly MIPS Technologies Inc.)

Can we add an another one vendor string for MIPS?

Any advice and suggestions will be greatly appreciated!

-- 
Best regards,
  Antony Pavlov
