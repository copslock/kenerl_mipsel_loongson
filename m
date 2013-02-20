Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Feb 2013 21:32:29 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:39852 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827512Ab3BTUc11wbT8 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Feb 2013 21:32:27 +0100
From:   Steven Hill <Steven.Hill@imgtec.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Kristian Kielhofner <kris@krisk.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH] MIPS: sead3_led: Use LED_CORE_SUSPENDRESUME
Thread-Topic: [PATCH] MIPS: sead3_led: Use LED_CORE_SUSPENDRESUME
Thread-Index: AQHODQoO43iokqJrJECFfgqPXf48m5iDN/+c
Date:   Wed, 20 Feb 2013 20:31:57 +0000
Message-ID: <0573B2AE5BBFFC408CC8740092293B5ACB3CB7@bamail02.ba.imgtec.org>
References: <1361104102-13294-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1361104102-13294-1-git-send-email-lars@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.64.117]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SEF-Processed: 7_3_0_01181__2013_02_20_20_32_21
X-archive-position: 35794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

This patch does not apply cleanly because of space/tab differences. In both of the lines below with '.brightness_set' the character between 't' and '=' needs to be a tab, not a space.

-Steve


@@ -34,33 +34,15 @@ static void sead3_fled_set(struct led_classdev *led_cdev,
 static struct led_classdev sead3_pled = {
         .name           = "sead3::pled",
         .brightness_set = sead3_pled_set,
+       .flags          = LED_CORE_SUSPENDRESUME,
 };
 
 static struct led_classdev sead3_fled = {
         .name           = "sead3::fled",
         .brightness_set = sead3_fled_set,
+       .flags          = LED_CORE_SUSPENDRESUME,
 };
