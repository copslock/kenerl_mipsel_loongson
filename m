Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Apr 2015 19:36:36 +0200 (CEST)
Received: from mail-qg0-f44.google.com ([209.85.192.44]:36454 "EHLO
        mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012906AbbDFRgcOwC9H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Apr 2015 19:36:32 +0200
Received: by qgeb100 with SMTP id b100so12639924qge.3
        for <linux-mips@linux-mips.org>; Mon, 06 Apr 2015 10:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=g48mU5aDEXGB4q6n24i2HZPyl9Dn8LRTHjjiLwA4dwE=;
        b=eYAJ9UR0dglxN0+VWsOIjG20Nc8R6J7Lr6oH0ZnXSd/W3I/8g2+kmCnCRbHMcwKyDU
         5W6uImPuINbuyH/z5pPRV+QD7Mbq87/6wREA5CU8okqIG2PnQwlz+/xNsPLBmwi6FF29
         RHW9wdj0TngfxsuPe/S7zBlpHEqasmur9Ej4Fo/+fFOMYAWekEo4cVJGyPZ6bH0LV0b4
         cDu258pF15ScVh4/qxd5ELPyvdsmWa1YylG3/VTlBk5Wu/0zSddLxl7ceERiyOGmUViv
         SGgdI0JRF4ArmrnYg8wWwbvwYyUbufg4kE4tWZkT2udyXtJZ8EmkT8Cq/kqTPxfJ5nbZ
         s1lQ==
X-Gm-Message-State: ALoCoQlo0XXJAp91/J9NJg9R8M377UeguIeM5lu1fOT0AJmjzbl0YehRWSsTsSo+XaorF0gFWUpG
X-Received: by 10.140.93.54 with SMTP id c51mr18267582qge.47.1428341786799;
        Mon, 06 Apr 2015 10:36:26 -0700 (PDT)
Received: from [192.168.1.139] (h96-61-87-245.cntcnh.dsl.dynamic.tds.net. [96.61.87.245])
        by mx.google.com with ESMTPSA id f77sm3595216qka.9.2015.04.06.10.36.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 10:36:26 -0700 (PDT)
Message-ID: <5522C40E.5060705@hurleysoftware.com>
Date:   Mon, 06 Apr 2015 13:36:14 -0400
From:   Peter Hurley <peter@hurleysoftware.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Rob Herring <robh@kernel.org>
CC:     Grant Likely <grant.likely@linaro.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH V3 5/7] serial: earlycon: Set UPIO_MEM32BE based on DT
 properties
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com> <1416872182-6440-6-git-send-email-cernekee@gmail.com> <54F3914F.3080905@hurleysoftware.com> <20150328013604.488A0C4091F@trevor.secretlab.ca> <5516DE64.6000104@hurleysoftware.com> <CAL_JsqKQD2ivpZ5kOy8ehmzsdFy8EMFZ-KvO2QS3fxtLgQL8Lw@mail.gmail.com> <551D61A5.8000604@hurleysoftware.com>
In-Reply-To: <551D61A5.8000604@hurleysoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <peter@hurleysoftware.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46794
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

On 04/02/2015 11:35 AM, Peter Hurley wrote:
> On 04/02/2015 09:46 AM, Rob Herring wrote:
>> Sorry about that. I had thought about doing the same thing. At least
>> unifying the macros, but not necessarily the tables. If it is also
>> extendable to other firmware interfaces like ACPI perhaps that would
>> be good.
> 
> No need to apologize; I'll make those changes and resubmit for your
> review.

What about something like the following?

This patch makes both __earlycon_table and __earlycon_of_table
arrays of struct earlycon_id, and a follow-on patch would use the
earlycon name to initialize the struct console fields.

The benefits of this approach are
1. diagnostics can readily identify the earlycon if there is some error
2. it would be trivial to enable both command line and devicetree
   earlycon from the same earlycon declaration.

And a single table is doable from this point.

AFAICT there is no benefit to using actual OF tables, and I see no
other reasonable way to initialize the name of the struct console
for devicetree earlycons.

Regards,
Peter Hurley


--- >% ---
Subject: [PATCH] serial: earlycon: Use common framework for earlycon
 declarations

Use common table definition and implementation macro to declare an
earlycon, but retain separate tables for command line and devicetree.
Add __EARLYCON_DECLARE() macro to instance a unique earlycon
declaration for the specified table.

This enables all earlycons to properly initialize the earlycon console
structure with name and index.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/of/fdt.c                  |  6 +++---
 drivers/tty/serial/earlycon.c     |  3 +--
 include/asm-generic/vmlinux.lds.h |  8 ++++++--
 include/linux/serial_core.h       | 30 +++++++++++++++++++++---------
 4 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 7cef9f9..f640efa 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -760,14 +760,14 @@ static inline void early_init_dt_check_for_initrd(unsigned long node)
 #endif /* CONFIG_BLK_DEV_INITRD */
 
 #ifdef CONFIG_SERIAL_EARLYCON
-extern struct of_device_id __earlycon_of_table[];
+extern struct earlycon_id __earlycon_of_table[];
 
 static int __init early_init_dt_scan_chosen_serial(void)
 {
 	int offset;
 	const char *p, *q;
 	int l;
-	const struct of_device_id *match = __earlycon_of_table;
+	const struct earlycon_id *match = __earlycon_of_table;
 	const void *fdt = initial_boot_params;
 
 	offset = fdt_path_offset(fdt, "/chosen");
@@ -800,7 +800,7 @@ static int __init early_init_dt_scan_chosen_serial(void)
 		if (!addr)
 			return -ENXIO;
 
-		of_setup_earlycon(addr, match->data);
+		of_setup_earlycon(addr, match->setup);
 		return 0;
 	}
 	return -ENODEV;
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 5fdc9f3..bf7eb76 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -19,7 +19,6 @@
 #include <linux/io.h>
 #include <linux/serial_core.h>
 #include <linux/sizes.h>
-#include <linux/mod_devicetable.h>
 
 #ifdef CONFIG_FIX_EARLYCON_MEM
 #include <asm/fixmap.h>
@@ -41,7 +40,7 @@ extern struct earlycon_id __earlycon_table[];
 static const struct earlycon_id __earlycon_table_sentinel
 	__used __section(__earlycon_table_end);
 
-static const struct of_device_id __earlycon_of_table_sentinel
+static const struct earlycon_id __earlycon_of_table_sentinel
 	__used __section(__earlycon_of_table_end);
 
 static void __iomem * __init earlycon_map(unsigned long paddr, size_t size)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 561daf4..7322c30 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -155,8 +155,13 @@
 			 VMLINUX_SYMBOL(__earlycon_table) = .;	\
 			 *(__earlycon_table)			\
 			 *(__earlycon_table_end)
+#define EARLYCON_OF_TABLE()	STRUCT_ALIGN();				 \
+				VMLINUX_SYMBOL(__earlycon_of_table) = .; \
+				*(__earlycon_of_table)			 \
+				*(__earlycon_of_table_end)
 #else
 #define EARLYCON_TABLE()
+#define EARLYCON_OF_TABLE()
 #endif
 
 #define ___OF_TABLE(cfg, name)	_OF_TABLE_##cfg(name)
@@ -175,7 +180,6 @@
 #define IOMMU_OF_TABLES()	OF_TABLE(CONFIG_OF_IOMMU, iommu)
 #define RESERVEDMEM_OF_TABLES()	OF_TABLE(CONFIG_OF_RESERVED_MEM, reservedmem)
 #define CPU_METHOD_OF_TABLES()	OF_TABLE(CONFIG_SMP, cpu_method)
-#define EARLYCON_OF_TABLES()	OF_TABLE(CONFIG_SERIAL_EARLYCON, earlycon)
 
 #define KERNEL_DTB()							\
 	STRUCT_ALIGN();							\
@@ -512,7 +516,7 @@
 	KERNEL_DTB()							\
 	IRQCHIP_OF_MATCH_TABLE()					\
 	EARLYCON_TABLE()						\
-	EARLYCON_OF_TABLES()
+	EARLYCON_OF_TABLE()
 
 #define INIT_TEXT							\
 	*(.init.text)							\
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 025dad9..9455e97 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -341,22 +341,34 @@ struct earlycon_device {
 
 struct earlycon_id {
 	char	name[16];
+	char	compatible[128];
 	int	(*setup)(struct earlycon_device *, const char *options);
 } __aligned(32);
 
+#define EARLYCON_TABLE __used __section(__earlycon_table)
+
+#ifdef CONFIG_OF
+#define EARLYCON_OF_TABLE __used __section(__earlycon_of_table)
+#else
+#define EARLYCON_OF_TABLE __attribute__((unused))
+#endif
+
+#define __EARLYCON_DECLARE(_name, compat, fn, pre, section)		\
+	static const struct earlycon_id __UNIQUE_ID(pre##_name) section	\
+		 = { .name = __stringify(_name),			\
+		     .compatible = compat,				\
+		     .setup = fn  }
+
+#define EARLYCON_DECLARE(_name, fn)					\
+	__EARLYCON_DECLARE(_name, "", fn, __earlycon_, EARLYCON_TABLE)
+
+#define OF_EARLYCON_DECLARE(_name, compat, fn)				\
+	__EARLYCON_DECLARE(_name, compat, fn, __earlycon_of_, EARLYCON_OF_TABLE)
+
 extern int setup_earlycon(char *buf);
 extern int of_setup_earlycon(unsigned long addr,
 			     int (*setup)(struct earlycon_device *, const char *));
 
-#define EARLYCON_DECLARE(_name, func)					\
-	static const struct earlycon_id __earlycon_##_name		\
-		__used __section(__earlycon_table)			\
-		 = { .name  = __stringify(_name),			\
-		     .setup = func  }
-
-#define OF_EARLYCON_DECLARE(name, compat, fn)				\
-	_OF_DECLARE(earlycon, name, compat, fn, void *)
-
 struct uart_port *uart_get_console(struct uart_port *ports, int nr,
 				   struct console *c);
 int uart_parse_earlycon(char *p, unsigned char *iotype, unsigned long *addr,
-- 
2.3.5
