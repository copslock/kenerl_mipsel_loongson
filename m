Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Mar 2005 22:59:23 +0000 (GMT)
Received: from adsl-67-116-42-149.dsl.sntc01.pacbell.net ([IPv6:::ffff:67.116.42.149]:44329
	"EHLO avtrex.com") by linux-mips.org with ESMTP id <S8229680AbVCYW7G>;
	Fri, 25 Mar 2005 22:59:06 +0000
Received: from [192.168.0.35] ([192.168.0.35] unverified) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 25 Mar 2005 14:58:46 -0800
Message-ID: <424497A4.4040206@avtrex.com>
Date:	Fri, 25 Mar 2005 14:58:44 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [Patch] Changes to make 2.4 build with gcc-4.0.0...
Content-Type: multipart/mixed;
 boundary="------------070208020208050408030304"
X-OriginalArrivalTime: 25 Mar 2005 22:58:46.0768 (UTC) FILETIME=[336AC700:01C5318E]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------070208020208050408030304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I just tried building my 2.4.29 kernel with gcc-4.0.0.  The attached 
patch is needed.

It seems to run fine but I have not extensively tested it.

The changes to include/asm/uaccess.h and include/linux/byteorder/swab.h 
are mostly back ports from CVS HEAD.  The rest is just random things 
that I had to change to make it work.

In addition to these changes you need the changes that are floating 
around on the list to asm-mips/ptrace.h, arch/mips/kernel/signal.c and 
arch/mips/kernel/syscall.c so that it will run when compiled with gcc-3.4

The diffs are from my internal CVS so version numbers will not match 
those on linux-mips' CVS.

David Daney.

--------------070208020208050408030304
Content-Type: text/plain;
 name="4.0.0.diffx"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="4.0.0.diffx"

Index: drivers/i2c/i2c-core.c
===================================================================
RCS file: /linux/linux/drivers/i2c/i2c-core.c,v
retrieving revision 1.3
diff -c -p -r1.3 i2c-core.c
*** drivers/i2c/i2c-core.c	2 Dec 2004 19:50:22 -0000	1.3
--- drivers/i2c/i2c-core.c	25 Mar 2005 22:22:12 -0000
*************** int i2c_master_send(struct i2c_client *c
*** 754,760 ****
  		msg.addr   = client->addr;
  		msg.flags = client->flags & I2C_M_TEN;
  		msg.len = count;
! 		(const char *)msg.buf = buf;
  	
  		DEB2(printk(KERN_DEBUG "i2c-core.o: master_send: writing %d bytes on %s.\n",
  			count,client->adapter->name));
--- 754,760 ----
  		msg.addr   = client->addr;
  		msg.flags = client->flags & I2C_M_TEN;
  		msg.len = count;
! 		msg.buf = (__u8 *)buf;
  	
  		DEB2(printk(KERN_DEBUG "i2c-core.o: master_send: writing %d bytes on %s.\n",
  			count,client->adapter->name));
*************** int i2c_master_recv(struct i2c_client *c
*** 784,790 ****
  		msg.flags = client->flags & I2C_M_TEN;
  		msg.flags |= I2C_M_RD;
  		msg.len = count;
! 		msg.buf = buf;
  
  		DEB2(printk(KERN_DEBUG "i2c-core.o: master_recv: reading %d bytes on %s.\n",
  			count,client->adapter->name));
--- 784,790 ----
  		msg.flags = client->flags & I2C_M_TEN;
  		msg.flags |= I2C_M_RD;
  		msg.len = count;
! 		msg.buf = (__u8 *)buf;
  
  		DEB2(printk(KERN_DEBUG "i2c-core.o: master_recv: reading %d bytes on %s.\n",
  			count,client->adapter->name));
Index: drivers/usb/inode.c
===================================================================
RCS file: /linux/linux/drivers/usb/inode.c,v
retrieving revision 1.1.1.1
diff -c -p -r1.1.1.1 inode.c
*** drivers/usb/inode.c	26 Feb 2004 19:15:00 -0000	1.1.1.1
--- drivers/usb/inode.c	25 Mar 2005 22:22:16 -0000
***************
*** 42,47 ****
--- 42,49 ----
  #include <asm/uaccess.h>
  
  /* --------------------------------------------------------------------- */
+ static struct file_operations usbdevfs_bus_file_operations;
+ static struct inode_operations usbdevfs_bus_inode_operations;
  
  /*
   * This list of superblocks is still used,
Index: include/asm-mips/uaccess.h
===================================================================
RCS file: /linux/linux/include/asm-mips/uaccess.h,v
retrieving revision 1.3
diff -c -p -r1.3 uaccess.h
*** include/asm-mips/uaccess.h	5 Feb 2005 01:03:58 -0000	1.3
--- include/asm-mips/uaccess.h	25 Mar 2005 22:22:17 -0000
*************** static inline int verify_area(int type, 
*** 149,155 ****
   * Returns zero on success, or -EFAULT on error.
   */
  #define put_user(x,ptr)	\
! 	__put_user_check((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))
  
  /*
   * get_user: - Get a simple variable from user space.
--- 149,155 ----
   * Returns zero on success, or -EFAULT on error.
   */
  #define put_user(x,ptr)	\
! 	__put_user_check((x),(ptr),sizeof(*(ptr)))
  
  /*
   * get_user: - Get a simple variable from user space.
*************** static inline int verify_area(int type, 
*** 169,175 ****
   * On error, the variable @x is set to zero.
   */
  #define get_user(x,ptr) \
! 	__get_user_check((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))
  
  /*
   * __put_user: - Write a simple value into user space, with less checking.
--- 169,175 ----
   * On error, the variable @x is set to zero.
   */
  #define get_user(x,ptr) \
! 	__get_user_check((x),(ptr),sizeof(*(ptr)))
  
  /*
   * __put_user: - Write a simple value into user space, with less checking.
*************** static inline int verify_area(int type, 
*** 191,197 ****
   * Returns zero on success, or -EFAULT on error.
   */
  #define __put_user(x,ptr) \
! 	__put_user_nocheck((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))
  
  /*
   * __get_user: - Get a simple variable from user space, with less checking.
--- 191,197 ----
   * Returns zero on success, or -EFAULT on error.
   */
  #define __put_user(x,ptr) \
! 	__put_user_nocheck((x),(ptr),sizeof(*(ptr)))
  
  /*
   * __get_user: - Get a simple variable from user space, with less checking.
*************** static inline int verify_area(int type, 
*** 214,220 ****
   * On error, the variable @x is set to zero.
   */
  #define __get_user(x,ptr) \
! 	__get_user_nocheck((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))
  
  struct __large_struct { unsigned long buf[100]; };
  #define __m(x) (*(struct __large_struct *)(x))
--- 214,220 ----
   * On error, the variable @x is set to zero.
   */
  #define __get_user(x,ptr) \
! 	__get_user_nocheck((x),(ptr),sizeof(*(ptr)))
  
  struct __large_struct { unsigned long buf[100]; };
  #define __m(x) (*(struct __large_struct *)(x))
*************** struct __large_struct { unsigned long bu
*** 232,238 ****
  #define __get_user_nocheck(x,ptr,size)					\
  ({									\
  	long __gu_err = 0;						\
! 	__typeof(*(ptr)) __gu_val = 0;					\
  	long __gu_addr;							\
  	__gu_addr = (long) (ptr);					\
  	switch (size) {							\
--- 232,238 ----
  #define __get_user_nocheck(x,ptr,size)					\
  ({									\
  	long __gu_err = 0;						\
! 	__typeof(*(ptr)) __gu_val = (__typeof(*(ptr))) 0;					\
  	long __gu_addr;							\
  	__gu_addr = (long) (ptr);					\
  	switch (size) {							\
*************** struct __large_struct { unsigned long bu
*** 248,254 ****
  
  #define __get_user_check(x,ptr,size)					\
  ({									\
! 	__typeof__(*(ptr)) __gu_val = 0;				\
  	long __gu_addr = (long) (ptr);					\
  	long __gu_err;							\
  									\
--- 248,254 ----
  
  #define __get_user_check(x,ptr,size)					\
  ({									\
! 	__typeof__(*(ptr)) __gu_val =  0;                               \
  	long __gu_addr = (long) (ptr);					\
  	long __gu_err;							\
  									\
Index: include/linux/fs.h
===================================================================
RCS file: /linux/linux/include/linux/fs.h,v
retrieving revision 1.5
diff -c -p -r1.5 fs.h
*** include/linux/fs.h	5 Feb 2005 01:03:57 -0000	1.5
--- include/linux/fs.h	25 Mar 2005 22:22:18 -0000
*************** static inline int is_mounted(kdev_t dev)
*** 1570,1576 ****
  unsigned long generate_cluster(kdev_t, int b[], int);
  unsigned long generate_cluster_swab32(kdev_t, int b[], int);
  extern kdev_t ROOT_DEV;
- extern char root_device_name[];
  
  
  extern void show_buffers(void);
--- 1570,1575 ----
Index: include/linux/i2c.h
===================================================================
RCS file: /linux/linux/include/linux/i2c.h,v
retrieving revision 1.5
diff -c -p -r1.5 i2c.h
*** include/linux/i2c.h	5 Feb 2005 01:03:58 -0000	1.5
--- include/linux/i2c.h	25 Mar 2005 22:22:18 -0000
*************** extern int i2c_master_recv(struct i2c_cl
*** 70,76 ****
  
  /* Transfer num messages.
   */
! extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],int num);
  
  /*
   * Some adapter types (i.e. PCF 8584 based ones) may support slave behaviuor. 
--- 70,76 ----
  
  /* Transfer num messages.
   */
! extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msg, int num);
  
  /*
   * Some adapter types (i.e. PCF 8584 based ones) may support slave behaviuor. 
*************** struct i2c_algorithm {
*** 197,203 ****
  	   to NULL. If an adapter algorithm can do SMBus access, set 
  	   smbus_xfer. If set to NULL, the SMBus protocol is simulated
  	   using common I2C messages */
! 	int (*master_xfer)(struct i2c_adapter *adap,struct i2c_msg msgs[], 
  	                   int num);
  	int (*smbus_xfer) (struct i2c_adapter *adap, u16 addr, 
  	                   unsigned short flags, char read_write,
--- 197,203 ----
  	   to NULL. If an adapter algorithm can do SMBus access, set 
  	   smbus_xfer. If set to NULL, the SMBus protocol is simulated
  	   using common I2C messages */
! 	int (*master_xfer)(struct i2c_adapter *adap,struct i2c_msg *msgs, 
  	                   int num);
  	int (*smbus_xfer) (struct i2c_adapter *adap, u16 addr, 
  	                   unsigned short flags, char read_write,
Index: include/linux/usbdevice_fs.h
===================================================================
RCS file: /linux/linux/include/linux/usbdevice_fs.h,v
retrieving revision 1.1.1.1
diff -c -p -r1.1.1.1 usbdevice_fs.h
*** include/linux/usbdevice_fs.h	26 Feb 2004 19:15:29 -0000	1.1.1.1
--- include/linux/usbdevice_fs.h	25 Mar 2005 22:22:21 -0000
*************** extern struct file_operations usbdevfs_d
*** 185,192 ****
  extern struct file_operations usbdevfs_devices_fops;
  extern struct file_operations usbdevfs_device_file_operations;
  extern struct inode_operations usbdevfs_device_inode_operations;
- extern struct inode_operations usbdevfs_bus_inode_operations;
- extern struct file_operations usbdevfs_bus_file_operations;
  extern void usbdevfs_conn_disc_event(void);
  
  #endif /* __KERNEL__ */
--- 185,190 ----
Index: include/linux/byteorder/swab.h
===================================================================
RCS file: /linux/linux/include/linux/byteorder/swab.h,v
retrieving revision 1.1.1.1
diff -c -p -r1.1.1.1 swab.h
*** include/linux/byteorder/swab.h	26 Feb 2004 19:15:29 -0000	1.1.1.1
--- include/linux/byteorder/swab.h	25 Mar 2005 22:22:21 -0000
***************
*** 156,162 ****
  #endif /* OPTIMIZE */
  
  
! static __inline__ __const__ __u16 __fswab16(__u16 x)
  {
  	return __arch__swab16(x);
  }
--- 156,162 ----
  #endif /* OPTIMIZE */
  
  
! static __inline__ __u16 __fswab16(__u16 x)
  {
  	return __arch__swab16(x);
  }
*************** static __inline__ void __swab16s(__u16 *
*** 169,175 ****
  	__arch__swab16s(addr);
  }
  
! static __inline__ __const__ __u32 __fswab24(__u32 x)
  {
  	return __arch__swab24(x);
  }
--- 169,175 ----
  	__arch__swab16s(addr);
  }
  
! static __inline__ __u32 __fswab24(__u32 x)
  {
  	return __arch__swab24(x);
  }
*************** static __inline__ void __swab24s(__u32 *
*** 182,188 ****
  	__arch__swab24s(addr);
  }
  
! static __inline__ __const__ __u32 __fswab32(__u32 x)
  {
  	return __arch__swab32(x);
  }
--- 182,188 ----
  	__arch__swab24s(addr);
  }
  
! static __inline__ __u32 __fswab32(__u32 x)
  {
  	return __arch__swab32(x);
  }
*************** static __inline__ void __swab32s(__u32 *
*** 196,202 ****
  }
  
  #ifdef __BYTEORDER_HAS_U64__
! static __inline__ __const__ __u64 __fswab64(__u64 x)
  {
  #  ifdef __SWAB_64_THRU_32__
  	__u32 h = x >> 32;
--- 196,202 ----
  }
  
  #ifdef __BYTEORDER_HAS_U64__
! static __inline__ __u64 __fswab64(__u64 x)
  {
  #  ifdef __SWAB_64_THRU_32__
  	__u32 h = x >> 32;
Index: include/net/icmp.h
===================================================================
RCS file: /linux/linux/include/net/icmp.h,v
retrieving revision 1.1.1.1
diff -c -p -r1.1.1.1 icmp.h
*** include/net/icmp.h	26 Feb 2004 19:15:21 -0000	1.1.1.1
--- include/net/icmp.h	25 Mar 2005 22:22:21 -0000
***************
*** 23,28 ****
--- 23,29 ----
  
  #include <net/sock.h>
  #include <net/protocol.h>
+ #include <net/snmp.h>
  
  struct icmp_err {
    int		errno;
Index: include/net/ipv6.h
===================================================================
RCS file: /linux/linux/include/net/ipv6.h,v
retrieving revision 1.1.1.2
diff -c -p -r1.1.1.2 ipv6.h
*** include/net/ipv6.h	1 Dec 2004 21:52:24 -0000	1.1.1.2
--- include/net/ipv6.h	25 Mar 2005 22:22:21 -0000
***************
*** 19,24 ****
--- 19,25 ----
  #include <asm/hardirq.h>
  #include <net/ndisc.h>
  #include <net/flow.h>
+ #include <net/snmp.h>
  
  #define SIN6_LEN_RFC2133	24
  

--------------070208020208050408030304--
