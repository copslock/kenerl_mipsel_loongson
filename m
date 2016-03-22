Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2016 06:41:17 +0100 (CET)
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35333 "EHLO
        mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008450AbcCVFlQgLWYT convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Mar 2016 06:41:16 +0100
Received: by mail-lb0-f174.google.com with SMTP id bc4so146720117lbc.2;
        Mon, 21 Mar 2016 22:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WXT712jXsCpL70KrmppJqN2BYWb+jMNH9Lz3VEDmuL4=;
        b=UJTPD9wzuyfXW0E/1qdUVJNzSKy0eueop14v6cWtwxNsm8BTJzHOVqNCx+dJycBwjt
         q7N/tqbdxtHy3R2DesMqwwqV3igfe/vgT6F3Fw+HfrxLpSa30bxUZfptH/jV59xfo0TA
         9B1Aa2t/odJLRgX03Xgq/Rjk2pQpQwK34HHinMkeSleWRHb85SB54shf5mDW8PZIiU6f
         VG2luUmEPptoSsl5gyGYuEVT8Yxpe6QnaS8KaumMrsZ4nMAV+Txin04yAAQzqVgXzsCX
         ujHglpB2/ooab+dyRf/x4XicGD5w5NGTdMzGXYmrURdwNtGzaRB/d6ZsKZ/Ojsp5mNyr
         rsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WXT712jXsCpL70KrmppJqN2BYWb+jMNH9Lz3VEDmuL4=;
        b=fJTN4epMUTYgXfgoRPlK9e8RdrTQedoXeEDJuvLvylo2LkNsw/h4IfKjlj+Ya11AV+
         P8p/CLP3gYyayL2mV+aezR+RKiVKBJ2Rd9qtrNU97u19kK1USuOvNUX8ebUOOMfQqYf0
         cuE0y3Ow7U6O+3czTXYJdr7QJld8KuXRa8rY7hxfHMIYrUl3cGMJE7llguzNDdveUQeV
         ycLRTdEoaCpyDmYJPyvH6zZW5Gg/r/vJsZInGM9Uh096lg37PoqyBFGOONHPBj3szQ1A
         w8iUjBMKUGxKvx5GanyvZ8S+a9wZey/ao4OiDYQpzm6mYUbpQ9MeDi45ThgGdznqKhQx
         0bvw==
X-Gm-Message-State: AD7BkJL4/UHW38Fme6WY86TXO6gCDlqaonPWZK79OEivpSSjXCOzPuIpC2/5tN4iESG9qg==
X-Received: by 10.112.160.232 with SMTP id xn8mr10316261lbb.22.1458625271145;
        Mon, 21 Mar 2016 22:41:11 -0700 (PDT)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id xf10sm5008918lbb.23.2016.03.21.22.41.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Mar 2016 22:41:10 -0700 (PDT)
Date:   Tue, 22 Mar 2016 08:40:46 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Matthias Schiffer <mschiffer@universe-factory.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Mamonov <pmamonov@gmail.com>
Subject: Re: Nonterministic hang during bootconsole/console handover on
 ath79
Message-Id: <20160322084046.7196890a7c157503cd0ea0d5@gmail.com>
In-Reply-To: <56F07DA1.8080404@universe-factory.net>
References: <56F07DA1.8080404@universe-factory.net>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52672
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

On Tue, 22 Mar 2016 00:02:57 +0100
Matthias Schiffer <mschiffer@universe-factory.net> wrote:

> Hi,
> we're experiencing weird nondeterministic hangs during bootconsole/console
> handover on some ath79 systems on OpenWrt. I've seen this issue myself on
> kernel 3.18.23~3.18.27 on a AR7241-based system, but according to other
> reports ([1], [2]) kernel 4.1.x is affected as well, and other SoCs like
> QCA953x likewise.
> 
> See the log below for the exact place it hangs; the log was taken in during
> a good boot; a bad boot will just hang forever at the marked location. The
> issue is extremely hard to debug, as changing the timing in any way (like
> adding additional printk) will usually make it work without problems. (Even
> recompiling the kernel with the same config, but different uname timestamp
> will make the occurence more or less likely)
> 
> My theory is the following:
> 
> As soon as ttyS0 is detected and installed as the console, there are two
> console drivers active on the serial port at the same time: early0 and
> ttyS0. I suspect that the hang occurs when the primitive early0
> implementation prom_putchar_ar71xx waits indefinitely on THRE,

Can you use EJTAG to prove your theory?

-- 
Best regards,
  Antony Pavlov
