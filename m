Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 11:57:58 +0200 (CEST)
Received: from mail-qy0-f192.google.com ([209.85.221.192]:62054 "EHLO
        mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492352Ab0EDJz2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 11:55:28 +0200
Received: by mail-qy0-f192.google.com with SMTP id 30so5119599qyk.16
        for <linux-mips@linux-mips.org>; Tue, 04 May 2010 02:55:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.222.144 with SMTP id ig16mr2756819qcb.74.1272966926905; 
        Tue, 04 May 2010 02:55:26 -0700 (PDT)
Received: by 10.229.212.206 with HTTP; Tue, 4 May 2010 02:55:26 -0700 (PDT)
Date:   Tue, 4 May 2010 17:55:26 +0800
Message-ID: <i2r180e2c241005040255jc7bcba2en11847fc49aebf3ad@mail.gmail.com>
Subject: [PATCH 7/12] add gdium platform devices
From:   yajin <yajinzhou@vm-kernel.org>
To:     linux-mips@linux-mips.org,
        loongson-dev <loongson-dev@googlegroups.com>,
        wuzhangjin@gmail.com, apatard@mandriva.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <yajinzhou@vm-kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yajinzhou@vm-kernel.org
Precedence: bulk
X-list: linux-mips

Add the gdium platform devices such as lm75 sensor and m41t83 rtc.

Signed-off-by: yajin <yajin@vm-kernel.org>
---
 arch/mips/loongson/Kconfig           |    4 +
 arch/mips/loongson/gdium/Makefile    |    2 +-
 arch/mips/loongson/gdium/platform.c  |  133 ++++++++++
 arch/mips/loongson/gdium/pwm-clock.c |  465 ++++++++++++++++++++++++++++++++++
 4 files changed, 603 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/loongson/gdium/platform.c
 create mode 100644 arch/mips/loongson/gdium/pwm-clock.c

diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 90a02b4..c264a84 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -80,10 +80,14 @@ config DEXXON_GDIUM
         select SYS_SUPPORTS_HIGHMEM
         select SYS_SUPPORTS_LITTLE_ENDIAN
         select ARCH_REQUIRE_GPIOLIB
+        select HAVE_PWM if MFD_SM501
         help
           Dexxon gdium netbook based on Loongson 2F and SM502.
 endchoice

+config HAVE_PWM
+	bool
+
 config CS5536
 	bool

diff --git a/arch/mips/loongson/gdium/Makefile
b/arch/mips/loongson/gdium/Makefile
index 31a8e57..4fb096d 100644
--- a/arch/mips/loongson/gdium/Makefile
+++ b/arch/mips/loongson/gdium/Makefile
@@ -1,3 +1,3 @@
 # Makefile for gdium

-obj-y += irq.o reset.o
+obj-y += irq.o reset.o platform.o pwm-clock.o
diff --git a/arch/mips/loongson/gdium/platform.c
b/arch/mips/loongson/gdium/platform.c
new file mode 100644
index 0000000..a6d5968
--- /dev/null
+++ b/arch/mips/loongson/gdium/platform.c
@@ -0,0 +1,133 @@
+/*
+ * Copyright (c) 2009 Philippe Vachon <philippe@cowpig.ca>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/pwm_backlight.h>
+#include <linux/i2c.h>
+#include <linux/i2c-gpio.h>
+
+#include <loongson.h>
+
+#define GDIUM_GPIO_BASE 224
+
+static struct i2c_board_info __initdata sm502dev_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("lm75", 0x48),
+		.type = "lm75",
+	},
+	{
+		I2C_BOARD_INFO("rtc-m41t80", 0x68),
+		.type = "m41t83",
+	},
+	{
+		I2C_BOARD_INFO("gdium-laptop", 0x40),
+	},
+};
+
+static int sm502dev_backlight_init(struct device *dev)
+{
+	/* Add gpio request stuff here */
+	return 0;
+}
+
+static void sm502dev_backlight_exit(struct device *dev)
+{
+	/* Add gpio free stuff here */
+}
+
+static struct platform_pwm_backlight_data backlight_data = {
+	.pwm_id		= 0,
+	.max_brightness	= 100,
+	.dft_brightness	= 50,
+	.pwm_period_ns	= 50000, /* 20 kHz */
+	.init		= sm502dev_backlight_init,
+	.exit		= sm502dev_backlight_exit,
+};
+
+static struct platform_device backlight = {
+	.name = "pwm-backlight",
+	.dev  = {
+		.platform_data = &backlight_data,
+	},
+	.id   = -1,
+};
+
+/*
+ * Warning this stunt is very dangerous
+ * as the sm501 gpio have dynamic numbers...
+ */
+/* bus 0 is the one for the ST7, DS75 etc... */
+static struct i2c_gpio_platform_data i2c_gpio0_data = {
+	.sda_pin	= GDIUM_GPIO_BASE + 13,
+	.scl_pin	= GDIUM_GPIO_BASE + 6,
+	.udelay		= 5,
+	.timeout	= HZ / 10,
+	.sda_is_open_drain = 0,
+	.scl_is_open_drain = 0,
+};
+
+static struct platform_device i2c_gpio0_device = {
+		.name		   = "i2c-gpio",
+		.id			 = 0,
+		.dev			 = {
+				.platform_data  = &i2c_gpio0_data,
+		},
+};
+
+/* bus 1 is for the CRT/VGA external screen */
+static struct i2c_gpio_platform_data i2c_gpio1_data = {
+	.sda_pin	= GDIUM_GPIO_BASE + 10,
+	.scl_pin	= GDIUM_GPIO_BASE + 9,
+	.udelay		= 5,
+	.timeout	= HZ / 10,
+	.sda_is_open_drain = 0,
+	.scl_is_open_drain = 0,
+};
+
+static struct platform_device i2c_gpio1_device = {
+		.name		   = "i2c-gpio",
+		.id			 = 1,
+		.dev			= {
+				.platform_data  = &i2c_gpio1_data,
+		},
+};
+
+static struct platform_device *devices[] __initdata = {
+	&i2c_gpio0_device,
+	&i2c_gpio1_device,
+	&backlight,
+};
+
+static int __init gdium_platform_devices_setup(void)
+{
+	int ret;
+	printk(KERN_INFO "Registering gdium platform devices\n");
+
+	platform_add_devices(devices, ARRAY_SIZE(devices));
+
+	ret = i2c_register_board_info(0, sm502dev_i2c_devices,
+		ARRAY_SIZE(sm502dev_i2c_devices));
+
+	if (ret != 0) {
+		printk(KERN_INFO "Error while registering gdium platform"
+				" devices: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * some devices are on the pwm stuff which is behind the mfd which is
+ * behind the pci bus so arch_initcall can't work because too early
+ */
+late_initcall(gdium_platform_devices_setup);
diff --git a/arch/mips/loongson/gdium/pwm-clock.c
b/arch/mips/loongson/gdium/pwm-clock.c
new file mode 100644
index 0000000..5af3b23
--- /dev/null
+++ b/arch/mips/loongson/gdium/pwm-clock.c
@@ -0,0 +1,465 @@
+/*
+ * SM501 PWM clock
+ * Copyright (C) 2009-2010 Arnaud Patard <apatard@mandriva.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/pwm.h>
+#include <linux/sm501.h>
+#include <linux/sm501-regs.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+static const char drv_name[] = "sm501-pwm";
+
+#define INPUT_CLOCK		96 /* MHz */
+#define PWM_COUNT		3
+
+#define SM501PWM_HIGH_COUNTER	(1<<20)
+#define SM501PWM_LOW_COUNTER	(1<<8)
+#define SM501PWM_CLOCK_DIVIDE	(1>>4)
+#define SM501PWM_IP		(1<<3)
+#define SM501PWM_I		(1<<2)
+#define SM501PWM_E		(1<<0)
+
+struct pwm_device {
+	struct list_head	node;
+	struct device		*dev;
+	void __iomem		*regs;
+	int			duty_ns;
+	int			period_ns;
+	char			enabled;
+	void			(*handler)(struct pwm_device *pwm);
+
+	const char		*label;
+	unsigned int		use_count;
+	unsigned int		pwm_id;
+};
+
+struct sm501pwm_info {
+	void __iomem	*regs;
+	int		irq;
+	struct resource *res;
+	struct device	*dev;
+	struct dentry	*debugfs;
+
+	struct pwm_device pwm[3];
+};
+
+int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
+{
+	unsigned int high, low, divider;
+	int divider1, divider2;
+	unsigned long long delay;
+
+	if (!pwm || !pwm->regs || period_ns == 0 || duty_ns > period_ns)
+		return -EINVAL;
+
+	/* Get delay
+	 * We're loosing some precision but multiplying then dividing
+	 * will overflow
+	 */
+	if (period_ns > 1000) {
+		delay = period_ns / 1000;
+		delay *= INPUT_CLOCK;
+	} else {
+		delay = period_ns * 96;
+		delay /= 1000;
+	}
+
+	/* Get the number of clock low and high */
+	high  = delay * duty_ns / period_ns;
+	low = delay - high;
+
+	/* Get divider to make 'low' and 'high' fit into 12 bits */
+	/* No need to say that the divider must be >= 0 */
+	divider1 = fls(low)-12;
+	divider2 = fls(high)-12;
+
+	if (divider1 < 0)
+		divider1 = 0;
+	if (divider2 < 0)
+		divider2 = 0;
+
+	divider = max(divider1, divider2);
+
+	low >>= divider;
+	high >>= divider;
+
+	pwm->duty_ns = duty_ns;
+	pwm->period_ns = period_ns;
+
+	writel((high<<20)|(low<<8)|(divider<<4), pwm->regs);
+	return 0;
+}
+EXPORT_SYMBOL(pwm_config);
+
+int pwm_enable(struct pwm_device *pwm)
+{
+	u32 reg;
+
+	if (!pwm)
+		return -EINVAL;
+
+	switch (pwm->pwm_id) {
+	case 0:
+		sm501_configure_gpio(pwm->dev->parent, 29, 1);
+		break;
+	case 1:
+		sm501_configure_gpio(pwm->dev->parent, 30, 1);
+		break;
+	case 2:
+		sm501_configure_gpio(pwm->dev->parent, 31, 1);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	reg = readl(pwm->regs);
+	reg |= (SM501PWM_IP | SM501PWM_E);
+	writel(reg, pwm->regs);
+	pwm->enabled = 1;
+
+	return 0;
+}
+EXPORT_SYMBOL(pwm_enable);
+
+void pwm_disable(struct pwm_device *pwm)
+{
+	u32 reg;
+
+	if (!pwm)
+		return;
+
+	reg = readl(pwm->regs);
+	reg &= ~(SM501PWM_IP | SM501PWM_E);
+	writel(reg, pwm->regs);
+
+	switch (pwm->pwm_id) {
+	case 0:
+		sm501_configure_gpio(pwm->dev->parent, 29, 0);
+		break;
+	case 1:
+		sm501_configure_gpio(pwm->dev->parent, 30, 0);
+		break;
+	case 2:
+		sm501_configure_gpio(pwm->dev->parent, 31, 0);
+		break;
+	default:
+		break;
+	}
+	pwm->enabled = 0;
+}
+EXPORT_SYMBOL(pwm_disable);
+
+static DEFINE_MUTEX(pwm_lock);
+static LIST_HEAD(pwm_list);
+
+struct pwm_device *pwm_request(int pwm_id, const char *label)
+{
+	struct pwm_device *pwm;
+	int found = 0;
+
+	mutex_lock(&pwm_lock);
+
+	list_for_each_entry(pwm, &pwm_list, node) {
+		if (pwm->pwm_id == pwm_id && pwm->use_count == 0) {
+			pwm->use_count++;
+			pwm->label = label;
+			found = 1;
+			break;
+		}
+	}
+
+	mutex_unlock(&pwm_lock);
+
+	return (found) ? pwm : NULL;
+}
+EXPORT_SYMBOL(pwm_request);
+
+void pwm_free(struct pwm_device *pwm)
+{
+	mutex_lock(&pwm_lock);
+
+	if (pwm->use_count) {
+		pwm->use_count--;
+		pwm->label = NULL;
+	} else
+		dev_warn(pwm->dev, "PWM device already freed\n");
+
+	mutex_unlock(&pwm_lock);
+}
+EXPORT_SYMBOL(pwm_free);
+
+int pwm_int_enable(struct pwm_device *pwm)
+{
+	unsigned long conf;
+
+	if (!pwm || !pwm->regs || !pwm->handler)
+		return -EINVAL;
+
+	conf = readl(pwm->regs);
+	conf |= SM501PWM_I;
+	writel(conf, pwm->regs);
+	return 0;
+}
+EXPORT_SYMBOL(pwm_int_enable);
+
+int pwm_int_disable(struct pwm_device *pwm)
+{
+	unsigned long conf;
+
+	if (!pwm || !pwm->regs || !pwm->handler)
+		return -EINVAL;
+
+	conf = readl(pwm->regs);
+	conf &= ~SM501PWM_I;
+	writel(conf, pwm->regs);
+	return 0;
+}
+EXPORT_SYMBOL(pwm_int_disable);
+
+int pwm_set_handler(struct pwm_device *pwm,
+		    void (*handler)(struct pwm_device *pwm))
+{
+	if (!pwm || !handler)
+		return -EINVAL;
+	pwm->handler = handler;
+	return 0;
+}
+EXPORT_SYMBOL(pwm_set_handler);
+
+static irqreturn_t sm501pwm_irq(int irq, void *dev_id)
+{
+	unsigned long value;
+	struct sm501pwm_info *info = (struct sm501pwm_info *)dev_id;
+	struct pwm_device *pwm;
+	int i;
+
+	value = sm501_modify_reg(info->dev->parent, SM501_IRQ_STATUS, 0, 0);
+
+	/* Check is the interrupt is for us */
+	if (value & (1<<22)) {
+		for (i = 0 ; i < PWM_COUNT ; i++) {
+			/*
+			 * Find which pwm triggered the interrupt
+			 * and ack
+			 */
+			value = readl(info->regs + i*4);
+			if (value & SM501PWM_IP)
+				writel(value | SM501PWM_IP, info->regs + i*4);
+
+			pwm = &info->pwm[i];
+			if (pwm->handler)
+				pwm->handler(pwm);
+		}
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static void add_pwm(int id, struct sm501pwm_info *info)
+{
+	struct pwm_device *pwm = &info->pwm[id];
+
+	pwm->use_count	= 0;
+	pwm->pwm_id	= id;
+	pwm->dev	= info->dev;
+	pwm->regs	= info->regs + id * 4;
+
+	mutex_lock(&pwm_lock);
+	list_add_tail(&pwm->node, &pwm_list);
+	mutex_unlock(&pwm_lock);
+}
+
+static void del_pwm(int id, struct sm501pwm_info *info)
+{
+	struct pwm_device *pwm = &info->pwm[id];
+
+	pwm->use_count  = 0;
+	pwm->pwm_id     = -1;
+	mutex_lock(&pwm_lock);
+	list_del(&pwm->node);
+	mutex_unlock(&pwm_lock);
+}
+
+/* Debug fs */
+static int sm501pwm_show(struct seq_file *s, void *p)
+{
+	struct pwm_device *pwm;
+
+	mutex_lock(&pwm_lock);
+	list_for_each_entry(pwm, &pwm_list, node) {
+		if (pwm->use_count) {
+			seq_printf(s, "pwm-%d (%12s) %d %d %s\n",
+					pwm->pwm_id, pwm->label,
+					pwm->duty_ns, pwm->period_ns,
+					pwm->enabled ? "on" : "off");
+			seq_printf(s, "       %08x\n", readl(pwm->regs));
+		}
+	}
+	mutex_unlock(&pwm_lock);
+
+	return 0;
+}
+
+static int sm501pwm_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, sm501pwm_show, inode->i_private);
+}
+
+static const struct file_operations sm501pwm_fops = {
+	.open		= sm501pwm_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.owner		= THIS_MODULE,
+};
+
+static int __init sm501pwm_probe(struct platform_device *pdev)
+{
+	struct sm501pwm_info *info;
+	struct device   *dev = &pdev->dev;
+	struct resource *res;
+	int ret = 0;
+	int res_len;
+	int i;
+
+	info = kzalloc(sizeof(struct sm501pwm_info), GFP_KERNEL);
+	if (!info) {
+		dev_err(dev, "Allocation failure\n");
+		ret = -ENOMEM;
+		goto err;
+	}
+	info->dev = dev;
+	platform_set_drvdata(pdev, info);
+
+	/* Get irq number */
+	info->irq = platform_get_irq(pdev, 0);
+	if (!info->irq) {
+		dev_err(dev, "no irq found\n");
+		ret = -ENODEV;
+		goto err_alloc;
+	}
+
+	/* Get regs address */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		dev_err(dev, "No memory resource found\n");
+		ret = -ENODEV;
+		goto err_alloc;
+	}
+	info->res = res;
+	res_len = (res->end - res->start)+1;
+
+	if (!request_mem_region(res->start, res_len, drv_name)) {
+		dev_err(dev, "Can't request iomem resource\n");
+		ret = -EBUSY;
+		goto err_alloc;
+	}
+
+	info->regs = ioremap(res->start, res_len);
+	if (!info->regs) {
+		dev_err(dev, "ioremap failed\n");
+		ret = -ENOMEM;
+		goto err_mem;
+	}
+
+	ret = request_irq(info->irq, sm501pwm_irq, IRQF_SHARED, drv_name, info);
+	if (ret != 0) {
+		dev_err(dev, "can't get irq\n");
+		goto err_map;
+	}
+
+
+	sm501_unit_power(info->dev->parent, SM501_GATE_GPIO, 1);
+
+	for (i = 0; i < 3; i++)
+		add_pwm(i, info);
+
+	dev_info(dev, "SM501 PWM Found at %lx irq %d\n",
+		 (unsigned long)info->res->start, info->irq);
+
+	info->debugfs = debugfs_create_file("pwm", S_IFREG | S_IRUGO,
+				NULL, info, &sm501pwm_fops);
+
+
+	return 0;
+
+err_map:
+	iounmap(info->regs);
+
+err_mem:
+	release_mem_region(res->start, res_len);
+
+err_alloc:
+	kfree(info);
+	platform_set_drvdata(pdev, NULL);
+err:
+	return ret;
+}
+
+static int sm501pwm_remove(struct platform_device *pdev)
+{
+	struct sm501pwm_info *info = platform_get_drvdata(pdev);
+	int i;
+
+	if (info->debugfs)
+		debugfs_remove(info->debugfs);
+
+	for (i = 0; i < 3; i++) {
+		pwm_disable(&info->pwm[i]);
+		del_pwm(i, info);
+	}
+
+	sm501_unit_power(info->dev->parent, SM501_GATE_GPIO, 0);
+	sm501_modify_reg(info->dev->parent, SM501_IRQ_STATUS, 0, 1<<22);
+
+	free_irq(info->irq, info);
+	iounmap(info->regs);
+	release_mem_region(info->res->start,
+			   (info->res->end - info->res->start)+1);
+	kfree(info);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver sm501pwm_driver = {
+	.probe		= sm501pwm_probe,
+	.remove		= sm501pwm_remove,
+	.driver		= {
+		.name	= drv_name,
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __devinit sm501pwm_init(void)
+{
+	return platform_driver_register(&sm501pwm_driver);
+}
+
+static void __exit sm501pwm_cleanup(void)
+{
+	platform_driver_unregister(&sm501pwm_driver);
+}
+
+module_init(sm501pwm_init);
+module_exit(sm501pwm_cleanup);
+
+MODULE_AUTHOR("Arnaud Patard <apatard@mandriva.com>");
+MODULE_DESCRIPTION("SM501 PWM driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:sm501-pwm");
-- 
1.5.6.5
