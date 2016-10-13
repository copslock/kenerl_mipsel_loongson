Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2016 05:18:05 +0200 (CEST)
Received: from mga04.intel.com ([192.55.52.120]:38897 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990505AbcJMDR6dmYUF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Oct 2016 05:17:58 +0200
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP; 12 Oct 2016 20:17:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,338,1473145200"; 
   d="gz'50?scan'50,208,50";a="19516176"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga004.jf.intel.com with ESMTP; 12 Oct 2016 20:17:49 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1buWXX-000BfN-RW; Thu, 13 Oct 2016 11:18:39 +0800
Date:   Thu, 13 Oct 2016 11:17:45 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     kbuild-all@01.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [mips-sjhill:mips-for-linux-next 85/126]
 drivers/auxdisplay/img-ascii-lcd.c:384: undefined reference to
 `devm_ioremap_resource'
Message-ID: <201610131133.i6LErSpl%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fengguang.wu@intel.com
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


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   git://git.linux-mips.org/pub/scm/sjhill/linux-sjhill.git mips-for-linux-next
head:   74f1077b5b783e7bf4fa3007cefdc8dbd6c07518
commit: 0cad855fbd083ee5fd0584a47c2aaa7dca936fd4 [85/126] auxdisplay: img-ascii-lcd: driver for simple ASCII LCD displays
config: um-allyesconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 0cad855fbd083ee5fd0584a47c2aaa7dca936fd4
        # save the attached .config to linux build tree
        make ARCH=um 

All errors (new ones prefixed by >>):

   arch/um/drivers/built-in.o: In function `vde_open_real':
   (.text+0xc7d1): warning: Using 'getgrnam' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   arch/um/drivers/built-in.o: In function `vde_open_real':
   (.text+0xc61c): warning: Using 'getpwuid' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   arch/um/drivers/built-in.o: In function `vde_open_real':
   (.text+0xc935): warning: Using 'getaddrinfo' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   arch/um/drivers/built-in.o: In function `pcap_nametoaddr':
   (.text+0x1d3c5): warning: Using 'gethostbyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   arch/um/drivers/built-in.o: In function `pcap_nametonetaddr':
   (.text+0x1d465): warning: Using 'getnetbyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   arch/um/drivers/built-in.o: In function `pcap_nametoproto':
   (.text+0x1d685): warning: Using 'getprotobyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   arch/um/drivers/built-in.o: In function `pcap_nametoport':
   (.text+0x1d4b7): warning: Using 'getservbyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   drivers/built-in.o: In function `fwnode_get_named_gpiod':
   drivers/gpio/gpiolib.c:3215: undefined reference to `of_get_named_gpiod_flags'
   drivers/built-in.o: In function `gpiod_get_index':
   drivers/gpio/gpiolib.c:3140: undefined reference to `of_get_named_gpiod_flags'
   drivers/built-in.o: In function `lp872x_probe':
   drivers/regulator/lp872x.c:773: undefined reference to `devm_gpio_request_one'
   drivers/regulator/lp872x.c:746: undefined reference to `devm_gpio_request_one'
   drivers/built-in.o: In function `max8952_pmic_probe':
   drivers/regulator/max8952.c:249: undefined reference to `devm_gpio_request_one'
   drivers/built-in.o: In function `max8973_probe':
   drivers/regulator/max8973-regulator.c:715: undefined reference to `devm_gpio_request_one'
   drivers/regulator/max8973-regulator.c:770: undefined reference to `devm_gpio_request_one'
   drivers/built-in.o: In function `pwm_regulator_probe':
   drivers/regulator/pwm-regulator.c:387: undefined reference to `devm_gpiod_get_optional'
   drivers/built-in.o: In function `tps62360_probe':
   drivers/regulator/tps62360-regulator.c:433: undefined reference to `devm_gpio_request_one'
   drivers/regulator/tps62360-regulator.c:444: undefined reference to `devm_gpio_request_one'
   drivers/built-in.o: In function `fdp_nci_i2c_probe':
   drivers/nfc/fdp/i2c.c:326: undefined reference to `devm_gpiod_get'
   drivers/built-in.o: In function `nfcmrvl_nci_unregister_dev':
   drivers/nfc/nfcmrvl/main.c:198: undefined reference to `devm_gpio_free'
   drivers/built-in.o: In function `nfcmrvl_nci_register_dev':
   drivers/nfc/nfcmrvl/main.c:127: undefined reference to `devm_gpio_request_one'
   drivers/built-in.o: In function `st21nfca_hci_i2c_probe':
   drivers/nfc/st21nfca/i2c.c:597: undefined reference to `devm_gpio_request_one'
   drivers/built-in.o: In function `st_nci_i2c_probe':
   drivers/nfc/st-nci/i2c.c:300: undefined reference to `devm_gpio_request_one'
   drivers/built-in.o: In function `nxp_nci_i2c_probe':
   drivers/nfc/nxp-nci/i2c.c:361: undefined reference to `devm_gpio_request_one'
   drivers/built-in.o: In function `mdio_gpio_probe':
   drivers/net/phy/mdio-gpio.c:177: undefined reference to `devm_gpio_request'
   drivers/built-in.o: In function `at803x_probe':
   drivers/net/phy/at803x.c:283: undefined reference to `devm_gpiod_get_optional'
   drivers/built-in.o: In function `mv88e6xxx_probe':
   drivers/net/dsa/mv88e6xxx/chip.c:4028: undefined reference to `devm_gpiod_get_optional'
   drivers/built-in.o: In function `img_ascii_lcd_probe':
>> drivers/auxdisplay/img-ascii-lcd.c:384: undefined reference to `devm_ioremap_resource'
   drivers/built-in.o: In function `pps_gpio_probe':
   drivers/pps/clients/pps-gpio.c:125: undefined reference to `devm_gpio_request'
   drivers/built-in.o: In function `max8903_probe':
   drivers/power/max8903_charger.c:248: undefined reference to `devm_gpio_request'
   drivers/power/max8903_charger.c:280: undefined reference to `devm_gpio_request'
   drivers/power/max8903_charger.c:243: undefined reference to `devm_gpio_request'
   drivers/built-in.o: In function `bq24257_probe':
   drivers/power/bq24257_charger.c:876: undefined reference to `devm_gpiod_get_optional'
   drivers/built-in.o: In function `bq24735_charger_probe':
   drivers/power/bq24735-charger.c:396: undefined reference to `devm_gpio_request'
   drivers/built-in.o: In function `bq25890_probe':
   drivers/power/bq25890_charger.c:726: undefined reference to `devm_gpiod_get_index'
   drivers/built-in.o: In function `intel_probe':
   drivers/bluetooth/hci_intel.c:1199: undefined reference to `devm_gpiod_get'
   drivers/built-in.o: In function `create_gpio_led':
   drivers/leds/leds-gpio.c:101: undefined reference to `devm_gpio_request_one'
   drivers/built-in.o: In function `gpio_led_probe':
   drivers/leds/leds-gpio.c:172: undefined reference to `devm_get_gpiod_from_child'
   drivers/built-in.o: In function `lp55xx_init_device':
   drivers/leds/leds-lp55xx-common.c:402: undefined reference to `devm_gpio_request_one'
   drivers/built-in.o: In function `lp8860_probe':
   drivers/leds/leds-lp8860.c:383: undefined reference to `devm_gpiod_get_optional'
   drivers/built-in.o: In function `lt3593_led_probe':
   drivers/leds/leds-lt3593.c:98: undefined reference to `devm_gpio_request_one'
   drivers/built-in.o: In function `ktd2692_probe':
   drivers/leds/leds-ktd2692.c:272: undefined reference to `devm_gpiod_get'
   drivers/built-in.o: In function `gpio_extcon_probe':
   drivers/extcon/extcon-gpio.c:69: undefined reference to `devm_gpio_request_one'
   drivers/built-in.o: In function `max3355_probe':
   drivers/extcon/extcon-max3355.c:68: undefined reference to `devm_gpiod_get'
   drivers/built-in.o: In function `usb_extcon_probe':
   drivers/extcon/extcon-usb-gpio.c:104: undefined reference to `devm_gpiod_get'
   drivers/built-in.o: In function `mma9551_probe':
   drivers/iio/accel/mma9551.c:421: undefined reference to `devm_gpiod_get_index'
   drivers/built-in.o: In function `ad5592r_probe':
   drivers/iio/dac/ad5592r-base.c:163: undefined reference to `devm_gpiod_get_optional'
   drivers/built-in.o: In function `ak8975_probe':
   drivers/iio/magnetometer/ak8975.c:886: undefined reference to `devm_gpio_request_one'
   drivers/built-in.o: In function `bmp280_common_probe':
   drivers/iio/pressure/bmp280-core.c:985: undefined reference to `devm_gpiod_get'
   drivers/built-in.o: In function `hp03_probe':
   drivers/iio/pressure/hp03.c:238: undefined reference to `devm_gpiod_get_index'
   drivers/built-in.o: In function `sx9500_probe':
   drivers/iio/proximity/sx9500.c:877: undefined reference to `devm_gpiod_get_index'
   net/built-in.o: In function `rfkill_gpio_probe':
   net/rfkill/rfkill-gpio.c:115: undefined reference to `devm_gpiod_get_optional'
   collect2: error: ld returned 1 exit status

vim +384 drivers/auxdisplay/img-ascii-lcd.c

   378	
   379			if (of_property_read_u32(pdev->dev.of_node, "offset",
   380						 &ctx->offset))
   381				return -EINVAL;
   382		} else {
   383			res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 > 384			ctx->base = devm_ioremap_resource(&pdev->dev, res);
   385			if (IS_ERR(ctx->base))
   386				return PTR_ERR(ctx->base);
   387		}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--gBBFr7Ir9EOA20Yy
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--gBBFr7Ir9EOA20Yy--
